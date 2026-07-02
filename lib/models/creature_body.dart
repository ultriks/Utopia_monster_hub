import 'action.dart';

enum CreatureBodyType {
  elemental,
  beast,
  humanoid,
  construct,
  draconic,
  abomination
}

class CreatureBody {
  final CreatureBodyType type;
  final String name;
  final int baseDr;

  final Map<String, int> bmsStats;
  final Map<String, int> defenses;
  final Map<String, int> subtraits;
  final Map<String, String> ratings;

  final List<CreatureAction> actions;
  final List<String> passives;
  final List<String> harvest;

  const CreatureBody({
    required this.type,
    required this.name,
    required this.baseDr,
    
    this.bmsStats = const {'shp': 0, 'dhp': 0, 'stamina': 0},
    this.defenses = const {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0},
    this.subtraits = const {
      'speed': 1, 'dexterity': 1, 'power': 1, 'fortitude': 1,
      'engineering': 1, 'memory': 1, 'resolve': 1, 'awareness': 1,
      'portrayal': 1, 'stunt': 1, 'appeal': 1, 'language': 1
    },
    this.ratings = const {'block': "1d4", 'dodge': "1d12"},

    this.actions = const [],
    this.passives = const [],
    this.harvest = const [],
  });
}
