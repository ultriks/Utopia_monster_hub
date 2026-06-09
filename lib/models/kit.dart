class Kit {
  final String id;
  final String name;
  final int drBonus;
  final int shpBonus;
  final int dhpBonus;
  final int staminaBonus;
  
  // Defenses
  final int physicalDefenseBonus;
  final int energyDefenseBonus;
  final int heatDefenseBonus;
  final int chillDefenseBonus;
  final int psycheDefenseBonus;
  
  // Subtraits
  final int speedBonus;
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
  final int languageBonus;

  // Ratings
  final int blockBonusDice;
  final int dodgeBonusDice;

  final List<String> passives;
  
  const Kit({
    required this.id,
    required this.name,
    required this.drBonus,
    this.shpBonus = 0,
    this.dhpBonus = 0,
    this.staminaBonus = 0,
    
    this.physicalDefenseBonus = 0,
    this.energyDefenseBonus = 0,
    this.heatDefenseBonus = 0,
    this.chillDefenseBonus = 0,
    this.psycheDefenseBonus = 0,

    this.speedBonus = 0,
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
    this.languageBonus = 0,

    this.blockBonusDice = 0,
    this.dodgeBonusDice = 0,
    this.passives = const [],
  });
}
