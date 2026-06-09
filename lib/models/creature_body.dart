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
  final int shp;
  final int dhp;
  final int stamina;
  
  // Defenses
  final int physicalDefense;
  final int energyDefense;
  final int heatDefense;
  final int chillDefense;
  final int psycheDefense;

  // Subtraits
  final int speed;
  final int dexterity;
  final int power;
  final int fortitude;
  final int engineering;
  final int memory;
  final int resolve;
  final int awareness;
  final int portrayal;
  final int stunt;
  final int appeal;
  final int language;

  // Ratings
  final String blockRating;
  final String dodgeRating;

  final List<CreatureAction> actions;
  final List<String> passives;
  final List<String> harvest;

  const CreatureBody({
    required this.type,
    required this.name,
    required this.baseDr,
    required this.shp,
    required this.dhp,
    required this.stamina,
    
    this.physicalDefense = 0,
    this.energyDefense = 0,
    this.heatDefense = 0,
    this.chillDefense = 0,
    this.psycheDefense = 0,

    this.speed = 1,
    this.dexterity = 1,
    this.power = 1,
    this.fortitude = 1,
    this.engineering = 1,
    this.memory = 1,
    this.resolve = 1,
    this.awareness = 1,
    this.portrayal = 1,
    this.stunt = 1,
    this.appeal = 1,
    this.language = 1,

    this.blockRating = "1d4",
    this.dodgeRating = "1d12",

    this.actions = const [],
    this.passives = const [],
    this.harvest = const [],
  });
}
