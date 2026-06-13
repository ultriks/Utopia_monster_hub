import 'action.dart';
import 'item.dart';

enum CreatureClassCategory {
  martial,
  arcane,
  support,
  innate
}

class CreatureClass {
  final String id;
  final String name;
  final CreatureClassCategory category;
  final int drBonus;
  final Map<String, int> bmsStatsBonus; //SHP, DHP, Stamina
  final Map<String, int> defenseBonus;
  final Map<String, int> subtraitBonus;
  final Map<String, int> ratingsBonus;
  final Map<String, int> travelBonus;

  final List<CreatureAction> actions;
  final List<String> passives;
  final List<Item> items;

  const CreatureClass({
    required this.id,
    required this.name,
    required this.category,
    required this.drBonus,

    this.bmsStatsBonus = const {'shp': 0, 'dhp': 0, 'stamina': 0, 'choice': 0},
    
    this.defenseBonus = const {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},

    this.subtraitBonus = const {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0, 
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},

    this.ratingsBonus = const {'block': 0, 'dodge': 0, 'choice': 0},

    this.travelBonus = const {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    
    this.actions = const [],
    this.passives = const [],
    this.items = const [],
  });
}
