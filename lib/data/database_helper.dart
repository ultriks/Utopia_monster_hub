import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/creature.dart';
import '../models/tag.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('utopia_monster_hub.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE creatures (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  body_type TEXT NOT NULL,
  kits_json TEXT,
  classes_json TEXT,
  custom_stats_json TEXT,
  actions_json TEXT,
  passives_json TEXT,
  final_dr INTEGER,
  shp INTEGER, dhp INTEGER, stamina INTEGER,
  created_at TEXT,
  updated_at TEXT,
  sync_status TEXT DEFAULT 'pending'
);
''');

    await db.execute('''
CREATE TABLE tags (
  id TEXT PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  color INTEGER
);
''');

    await db.execute('''
CREATE TABLE creature_tags (
  creature_id TEXT REFERENCES creatures(id) ON DELETE CASCADE,
  tag_id TEXT REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (creature_id, tag_id)
);
''');
  }

  // ---------- Creature CRUD ----------

  Future<void> createCreature(Creature creature) async {
    try {
      final db = await instance.database;
      await db.insert('creatures', creature.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      debugPrint("Error creating creature: $e");
      rethrow;
    }
  }

  Future<List<Creature>> readAllCreatures() async {
    final db = await instance.database;

    // Fetch all creatures
    final creatureMaps = await db.query('creatures');

    if (creatureMaps.isEmpty) return [];

    // Fetch all creature-tag associations with tag data via a JOIN
    final tagRows = await db.rawQuery('''
      SELECT ct.creature_id, t.id, t.name, t.color
      FROM creature_tags ct
      INNER JOIN tags t ON ct.tag_id = t.id
    ''');

    // Build a lookup: creatureId → list of Tags
    final Map<String, List<Tag>> tagsByCreature = {};
    for (var row in tagRows) {
      final creatureId = row['creature_id'] as String;
      final tag = Tag(
        id: row['id'] as String,
        name: row['name'] as String,
        color: row['color'] as int?,
      );
      tagsByCreature.putIfAbsent(creatureId, () => []).add(tag);
    }

    return creatureMaps.map((map) {
      final creature = Creature.fromMap(map);
      creature.tags = tagsByCreature[creature.id] ?? [];
      return creature;
    }).toList();
  }

  Future<void> updateCreature(Creature creature) async {
    try {
      final db = await instance.database;
      await db.update(
        'creatures',
        creature.toMap(),
        where: 'id = ?',
        whereArgs: [creature.id],
      );
    } catch (e) {
      debugPrint("Error updating creature: $e");
      rethrow;
    }
  }

  Future<void> deleteCreature(String id) async {
    final db = await instance.database;
    await db.delete(
      'creatures',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ---------- Tag CRUD ----------

  Future<void> createTag(Tag tag) async {
    final db = await instance.database;
    await db.insert('tags', tag.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Tag>> readAllTags() async {
    final db = await instance.database;
    final maps = await db.query('tags');
    if (maps.isNotEmpty) {
      return maps.map((map) => Tag.fromMap(map)).toList();
    } else {
      return [];
    }
  }

  Future<void> addTagToCreature(String creatureId, String tagId) async {
    final db = await instance.database;
    await db.insert('creature_tags', {
      'creature_id': creatureId,
      'tag_id': tagId,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> removeTagFromCreature(String creatureId, String tagId) async {
    final db = await instance.database;
    await db.delete(
      'creature_tags',
      where: 'creature_id = ? AND tag_id = ?',
      whereArgs: [creatureId, tagId],
    );
  }
}
