class Kit {
  final String id;
  final String name;
  final int drBonus;
  final Map<String, int> bmsStatsBonus;
  /* final int shpBonus;
  final int dhpBonus;
  final int staminaBonus;*/
  
  // Defenses
  final Map<String, int> defenseBonus;
  /* final int physicalDefenseBonus;
  final int energyDefenseBonus;
  final int heatDefenseBonus;
  final int chillDefenseBonus;
  final int psycheDefenseBonus; */
  
  // Subtraits
  final Map<String, int> subtraitBonus;
  /*final int speedBonus;
  final int dexterityBonus;
  final int powerBonus;
  final int fortitudeBonus;
  final int engineeringBonus;
  final int memoryBonus;
  final int resolveBonus;
  final int awarenessBonus;
  final int portrayalBonus;
  final int stuntBonus;
  final int appealBonus;
  final int languageBonus;*/

  // Ratings
  final Map<String, int> ratingsBonus;

  /*final int blockBonusDice;
  final int dodgeBonusDice;*/

  final Map<String, int> travelBonus;

  final List<String> passives;
  
  const Kit({
    required this.id,
    required this.name,
    required this.drBonus,
    /*this.shpBonus = 0,
    this.dhpBonus = 0,
    this.staminaBonus = 0,*/

    this.bmsStatsBonus = const {'shp': 0, 'dhp': 0, 'stamina': 0, 'choice': 0},

    this.defenseBonus = const {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},

    
    /*this.physicalDefenseBonus = 0,
    this.energyDefenseBonus = 0,
    this.heatDefenseBonus = 0,
    this.chillDefenseBonus = 0,
    this.psycheDefenseBonus = 0,*/

    this.subtraitBonus = const {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0, 
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},

    /*this.speedBonus = 0,
    this.dexterityBonus = 0,
    this.powerBonus = 0,
    this.fortitudeBonus = 0,
    this.engineeringBonus = 0,
    this.memoryBonus = 0,
    this.resolveBonus = 0,
    this.awarenessBonus = 0,
    this.portrayalBonus = 0,
    this.stuntBonus = 0,
    this.appealBonus = 0,
    this.languageBonus = 0,*/

    this.ratingsBonus = const {'block': 0, 'dodge': 0, 'choice': 0},

    /*this.blockBonusDice = 0,
    this.dodgeBonusDice = 0,*/

    this.travelBonus = const {'land': 0, 'water': 0, 'air': 0, 'choice': 0},

    this.passives = const [],
  });
}
