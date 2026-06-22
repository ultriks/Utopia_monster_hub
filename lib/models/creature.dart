import 'dart:convert';
import 'action.dart';
import 'creature_body.dart';
import 'creature_class.dart';
import 'kit.dart';
import 'tag.dart';
import '../data/creature_bodies.dart';
import '../data/kits_data.dart';
import '../data/classes_data.dart';
import '../data/items_data.dart';
import '../models/item.dart';

class Creature {
  final String id;
  String name;
  String description;
  CreatureBodyType bodyType;
  List<Map<String, dynamic>> kits; // { "kitId": string, "stacks": int }
  List<String> classes;
  List<String> items;
  Map<String, int> customStats;
  List<CreatureAction> actions;
  List<String> passives;
  
  int finalDr;
  int shp;
  int dhp;
  int stamina;
  
  String createdAt;
  String updatedAt;
  String syncStatus;

  List<Tag> tags;

  Creature({
    required this.id,
    required this.name,
    this.description = '',
    required this.bodyType,
    this.kits = const [],
    this.classes = const [],
    this.items = const [],
    this.customStats = const {},
    this.actions = const [],
    this.passives = const [],
    this.finalDr = 0,
    this.shp = 0,
    this.dhp = 0,
    this.stamina = 0,
    required this.createdAt,
    required this.updatedAt,
    this.syncStatus = 'pending',
    this.tags = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'body_type': bodyType.name,
      'kits_json': jsonEncode(kits),
      'classes_json': jsonEncode(classes),
      'items_json': jsonEncode(items),
      'custom_stats_json': jsonEncode(customStats),
      'actions_json': jsonEncode(actions.map((x) => x.toMap()).toList()),
      'passives_json': jsonEncode(passives),
      'final_dr': finalDr,
      'shp': shp,
      'dhp': dhp,
      'stamina': stamina,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sync_status': syncStatus,
    };
  }

  factory Creature.fromMap(Map<String, dynamic> map) {
    return Creature(
      id: map['id'],
      name: map['name'],
      description: map['description'] ?? '',
      bodyType: CreatureBodyType.values.firstWhere((e) => e.name == map['body_type'], orElse: () => CreatureBodyType.humanoid),
      kits: List<Map<String, dynamic>>.from(jsonDecode(map['kits_json'] ?? '[]')),
      classes: List<String>.from(jsonDecode(map['classes_json'] ?? '[]')),
      items: List<String>.from(jsonDecode(map['items_json'] ?? '[]')),
      customStats: Map<String, int>.from(jsonDecode(map['custom_stats_json'] ?? '{}')),
      actions: List<CreatureAction>.from(
        (jsonDecode(map['actions_json'] ?? '[]') as List).map((x) => CreatureAction.fromMap(x))
      ),
      passives: List<String>.from(jsonDecode(map['passives_json'] ?? '[]')),
      finalDr: map['final_dr'] ?? 0,
      shp: map['shp'] ?? 0,
      dhp: map['dhp'] ?? 0,
      stamina: map['stamina'] ?? 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      syncStatus: map['sync_status'] ?? 'pending',
    );
  }

  // --- Computed Properties ---

  CreatureBody get _baseBody => creatureBodies.firstWhere((b) => b.type == bodyType, orElse: () => creatureBodies.first);
  
  List<Kit> get _activeKits {
    final list = <Kit>[];
    for (var kitEntry in kits) {
      final kitId = kitEntry['kitId'] as String?;
      final stacks = kitEntry['stacks'] as int? ?? 1;
      if (kitId != null) {
        final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
        if (kit != null) {
          for (int i=0; i<stacks; i++) {
            list.add(kit);
          }
        }
      }
    }
    return list;
  }
  
  List<CreatureClass> get _activeClasses {
    final list = <CreatureClass>[];
    for (var classId in classes) {
      final cls = classesData.where((c) => c.id == classId).firstOrNull;
      if (cls != null) list.add(cls);
    }
    return list;
  }

  int get computedDr {
    int dr = _baseBody.baseDr;
    for (var k in _activeKits) { dr += k.drBonus; }
    for (var c in _activeClasses) { dr += c.drBonus; }
    return dr;
  }


  int getBmsStat(String statName) {
    int val = 0;
    switch (statName) {
      case 'shp': val = _baseBody.shp; break;
      case 'dhp': val = _baseBody.dhp; break;
      case 'stamina': val = _baseBody.stamina; break;
    }
    val += customStats[statName] ?? 0;
    for (var k in _activeKits) { val += k.bmsStatsBonus[statName] ?? 0; }
    for (var c in _activeClasses) { val += c.bmsStatsBonus[statName] ?? 0; }
    return val;
  }

  int getDefense(String name) {
    int val = 0;
    switch (name) {
      case 'physical': val = _baseBody.physicalDefense; break;
      case 'energy': val = _baseBody.energyDefense; break;
      case 'heat': val = _baseBody.heatDefense; break;
      case 'chill': val = _baseBody.chillDefense; break;
      case 'psyche': val = _baseBody.psycheDefense; break;
    }
    val += customStats['${name}Defense'] ?? 0;
    for (var k in _activeKits) { val += k.defenseBonus[name] ?? 0; }
    for (var c in _activeClasses) { val += c.defenseBonus[name] ?? 0; }
    return val;
  }

  int getSubtrait(String name) {
    int val = 0;
    switch (name) {
      case 'speed': val = _baseBody.speed; break;
      case 'dexterity': val = _baseBody.dexterity; break;
      case 'power': val = _baseBody.power; break;
      case 'fortitude': val = _baseBody.fortitude; break;
      case 'engineering': val = _baseBody.engineering; break;
      case 'memory': val = _baseBody.memory; break;
      case 'resolve': val = _baseBody.resolve; break;
      case 'awareness': val = _baseBody.awareness; break;
      case 'portrayal': val = _baseBody.portrayal; break;
      case 'stunt': val = _baseBody.stunt; break;
      case 'appeal': val = _baseBody.appeal; break;
      case 'language': val = _baseBody.language; break;
    }
    val += customStats[name] ?? 0;
    for (var k in _activeKits) { val += k.subtraitBonus[name] ?? 0; }
    for (var c in _activeClasses) { val += c.subtraitBonus[name] ?? 0; }
    return val;
  }

  String _addDice(String baseDice, int bonus) {
    if (bonus == 0) return baseDice;
    final parts = baseDice.split('d');
    if (parts.length == 2) {
      int count = int.tryParse(parts[0]) ?? 0;
      return '${count + bonus}d${parts[1]}';
    }
    return baseDice;
  }

  String getRating(String name) {
    int bonus = 0;
    bonus += customStats['${name}Rating'] ?? 0;
    for (var k in _activeKits) { bonus += k.ratingsBonus[name] ?? 0; }
    for (var c in _activeClasses) { bonus += c.ratingsBonus[name] ?? 0; }
    
    String baseRating = '';
    if (name == 'block') { baseRating = _baseBody.blockRating; }
    else if (name == 'dodge') { baseRating = _baseBody.dodgeRating; }
    
    return _addDice(baseRating, bonus);
  }

  List<CreatureAction> get computedActions {
    final list = List<CreatureAction>.from(_baseBody.actions);
    for (var c in _activeClasses) { list.addAll(c.actions); }
    list.addAll(actions);
    for (var itemId in items) {
      final item = itemsData.where((i) => i.id == itemId).firstOrNull;
      if (item is Weapon) {
        String dmg = '${item.damage.$1}d${item.damage.$2}';
        if (item.damage.$3 != null) dmg += ' + [${item.damage.$3}]';
        String rng = '${item.range.$1}';
        if (item.range.$2 != null) rng += '-${item.range.$2}';
        list.add(CreatureAction(
          name: item.name,
          description: "Attack with ${item.name} (TA: ${item.TA}, Damage: $dmg ${item.damageType.name}). Range: $rng.",
        ));
      }
    }
    return list;
  }

  List<String> get computedPassives {
    final list = List<String>.from(_baseBody.passives);
    for (var c in _activeClasses) { list.addAll(c.passives); }
    for (var k in kits) {
      final kitId = k['kitId'] as String?;
      final stacks = k['stacks'] as int? ?? 1;
      if (kitId != null) {
        final kitDef = kitsData.where((x) => x.id == kitId).firstOrNull;
        if (kitDef != null) {
          for (var passive in kitDef.passives) {
             list.add(stacks > 1 ? '$passive (×$stacks)' : passive);
          }
        }
      }
    }
    list.addAll(passives);
    return list;
  }

  void recalculateBaseStats() {
    finalDr = computedDr;
    shp = getBmsStat('shp');
    dhp = getBmsStat('dhp');
    stamina = getBmsStat('stamina');
  }
}
