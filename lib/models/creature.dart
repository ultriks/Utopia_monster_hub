import 'dart:convert';
import 'action.dart';
import 'creature_body.dart';
import 'creature_class.dart';
import 'kit.dart';
import 'tag.dart';
import '../data/creature_bodies.dart';
import '../data/kits_data.dart';
import '../data/classes_data.dart';

class Creature {
  final String id;
  String name;
  String description;
  CreatureBodyType bodyType;
  List<Map<String, dynamic>> kits; // { "kitId": string, "stacks": int }
  List<String> classes;
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
    for (var k in _activeKits) dr += k.drBonus;
    for (var c in _activeClasses) dr += c.drBonus;
    return dr;
  }

  int get computedShp {
    int val = _baseBody.shp;
    for (var k in _activeKits) val += k.shpBonus;
    for (var c in _activeClasses) val += c.shpBonus;
    return val;
  }

  int get computedDhp {
    int val = _baseBody.dhp;
    for (var k in _activeKits) val += k.dhpBonus;
    for (var c in _activeClasses) val += c.dhpBonus;
    return val;
  }

  int get computedStamina {
    int val = _baseBody.stamina;
    for (var k in _activeKits) val += k.staminaBonus;
    for (var c in _activeClasses) val += c.staminaBonus;
    return val;
  }

  // Defenses
  int get computedPhysicalDefense {
    int val = _baseBody.physicalDefense + (customStats['physicalDefense'] ?? 0);
    for (var k in _activeKits) val += k.physicalDefenseBonus;
    for (var c in _activeClasses) val += c.physicalDefenseBonus;
    return val;
  }

  int get computedEnergyDefense {
    int val = _baseBody.energyDefense + (customStats['energyDefense'] ?? 0);
    for (var k in _activeKits) val += k.energyDefenseBonus;
    for (var c in _activeClasses) val += c.energyDefenseBonus;
    return val;
  }

  int get computedHeatDefense {
    int val = _baseBody.heatDefense + (customStats['heatDefense'] ?? 0);
    for (var k in _activeKits) val += k.heatDefenseBonus;
    for (var c in _activeClasses) val += c.heatDefenseBonus;
    return val;
  }

  int get computedChillDefense {
    int val = _baseBody.chillDefense + (customStats['chillDefense'] ?? 0);
    for (var k in _activeKits) val += k.chillDefenseBonus;
    for (var c in _activeClasses) val += c.chillDefenseBonus;
    return val;
  }

  int get computedPsycheDefense {
    int val = _baseBody.psycheDefense + (customStats['psycheDefense'] ?? 0);
    for (var k in _activeKits) val += k.psycheDefenseBonus;
    for (var c in _activeClasses) val += c.psycheDefenseBonus;
    return val;
  }

  // Subtraits
  int get computedSpeed {
    int val = _baseBody.speed + (customStats['speed'] ?? 0);
    for (var k in _activeKits) val += k.speedBonus;
    for (var c in _activeClasses) val += c.speedBonus;
    return val;
  }

  int get computedDexterity {
    int val = _baseBody.dexterity + (customStats['dexterity'] ?? 0);
    for (var k in _activeKits) val += k.dexterityBonus;
    for (var c in _activeClasses) val += c.dexterityBonus;
    return val;
  }

  int get computedPower {
    int val = _baseBody.power + (customStats['power'] ?? 0);
    for (var k in _activeKits) val += k.powerBonus;
    for (var c in _activeClasses) val += c.powerBonus;
    return val;
  }

  int get computedFortitude {
    int val = _baseBody.fortitude + (customStats['fortitude'] ?? 0);
    for (var k in _activeKits) val += k.fortitudeBonus;
    for (var c in _activeClasses) val += c.fortitudeBonus;
    return val;
  }

  int get computedEngineering {
    int val = _baseBody.engineering + (customStats['engineering'] ?? 0);
    for (var k in _activeKits) val += k.engineeringBonus;
    for (var c in _activeClasses) val += c.engineeringBonus;
    return val;
  }

  int get computedMemory {
    int val = _baseBody.memory + (customStats['memory'] ?? 0);
    for (var k in _activeKits) val += k.memoryBonus;
    for (var c in _activeClasses) val += c.memoryBonus;
    return val;
  }

  int get computedResolve {
    int val = _baseBody.resolve + (customStats['resolve'] ?? 0);
    for (var k in _activeKits) val += k.resolveBonus;
    for (var c in _activeClasses) val += c.resolveBonus;
    return val;
  }

  int get computedAwareness {
    int val = _baseBody.awareness + (customStats['awareness'] ?? 0);
    for (var k in _activeKits) val += k.awarenessBonus;
    for (var c in _activeClasses) val += c.awarenessBonus;
    return val;
  }

  int get computedPortrayal {
    int val = _baseBody.portrayal + (customStats['portrayal'] ?? 0);
    for (var k in _activeKits) val += k.portrayalBonus;
    for (var c in _activeClasses) val += c.portrayalBonus;
    return val;
  }

  int get computedStunt {
    int val = _baseBody.stunt + (customStats['stunt'] ?? 0);
    for (var k in _activeKits) val += k.stuntBonus;
    for (var c in _activeClasses) val += c.stuntBonus;
    return val;
  }

  int get computedAppeal {
    int val = _baseBody.appeal + (customStats['appeal'] ?? 0);
    for (var k in _activeKits) val += k.appealBonus;
    for (var c in _activeClasses) val += c.appealBonus;
    return val;
  }

  int get computedLanguage {
    int val = _baseBody.language + (customStats['language'] ?? 0);
    for (var k in _activeKits) val += k.languageBonus;
    for (var c in _activeClasses) val += c.languageBonus;
    return val;
  }

  // Ratings
  String _addDice(String baseDice, int bonus) {
    if (bonus == 0) return baseDice;
    final parts = baseDice.split('d');
    if (parts.length == 2) {
      int count = int.tryParse(parts[0]) ?? 0;
      return '${count + bonus}d${parts[1]}';
    }
    return baseDice;
  }

  String get computedBlockRating {
    int bonus = 0;
    for (var k in _activeKits) bonus += k.blockBonusDice;
    for (var c in _activeClasses) bonus += c.blockBonusDice;
    return _addDice(_baseBody.blockRating, bonus);
  }

  String get computedDodgeRating {
    int bonus = 0;
    for (var k in _activeKits) bonus += k.dodgeBonusDice;
    for (var c in _activeClasses) bonus += c.dodgeBonusDice;
    return _addDice(_baseBody.dodgeRating, bonus);
  }

  List<CreatureAction> get computedActions {
    final list = List<CreatureAction>.from(_baseBody.actions);
    for (var c in _activeClasses) list.addAll(c.actions);
    list.addAll(actions);
    return list;
  }

  List<String> get computedPassives {
    final list = List<String>.from(_baseBody.passives);
    for (var c in _activeClasses) list.addAll(c.passives);
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
    shp = computedShp;
    dhp = computedDhp;
    stamina = computedStamina;
  }
}
