import '../models/creature_class.dart';
import '../models/action.dart';

final List<CreatureClass> classesData = [
  // Martial
  CreatureClass(
    id: 'brute',
    name: 'Brute',
    category: CreatureClassCategory.martial,
    drBonus: 8,
    shpBonus: 25,
    dhpBonus: 15,
    physicalDefenseBonus: 2,
    energyDefenseBonus: 1,
    heatDefenseBonus: 1,
    chillDefenseBonus: 1,
    powerBonus: 4,
    speedBonus: 2,
    fortitudeBonus: 2,
    blockBonusDice: 1,
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target’s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack',
        description: '1 Turn Action. 0 meters (Melee). 4d4 Physical damage.'
      )
    ]
  ),
  CreatureClass(
    id: 'martialist',
    name: 'Martialist',
    category: CreatureClassCategory.martial,
    drBonus: 15,
    shpBonus: 35,
    dhpBonus: 30,
    staminaBonus: 10,
    physicalDefenseBonus: 4,
    energyDefenseBonus: 2,
    heatDefenseBonus: 2,
    chillDefenseBonus: 2,
    dexterityBonus: 5,
    powerBonus: 5,
    speedBonus: 3,
    fortitudeBonus: 2,
    dodgeBonusDice: 2,
    blockBonusDice: 2,
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target’s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.',
      'When this creature takes the Travel action, it may spend 3 stamina to add its Power score to its Land travel for the rest of the action.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack (Melee)',
        description: '3 Turn Actions. 2 meters (Melee). 5d12 Physical damage.'
      ),
      CreatureAction(
        name: 'Attack (Ranged)',
        description: '3 Turn Actions. 20/40 meters (Ranged). 5d8 + [Dexterity Mod] Physical'
      )
    ]
  ),
  CreatureClass(
    id: 'militant',
    name: 'Militant',
    category: CreatureClassCategory.martial,
    drBonus: 30,
    shpBonus: 70,
    dhpBonus: 60,
    staminaBonus: 20,
    physicalDefenseBonus: 7,
    energyDefenseBonus: 5,
    heatDefenseBonus: 4,
    chillDefenseBonus: 4,
    dexterityBonus: 8,
    powerBonus: 8,
    speedBonus: 6,
    fortitudeBonus: 4,
    resolveBonus: 4,
    dodgeBonusDice: 3,
    blockBonusDice: 4,
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target’s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.',
      'When this creature takes the Travel action, it may spend 3 stamina to add its Power score to its Land travel for the rest of the action.',
      'Whenever another creature that this one can sense takes the Attack action, this creature may spend 8 stamina to take the Attack action using interrupt actions as if they were turn actions.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack (Melee)',
        description: '2 Turn Actions. 1 meter (Melee). 5d6 Energy damage.'
      ),
      CreatureAction(
        name: 'Attack (Ranged)',
        description: '2 Turn Actions. 20/40 meters (Ranged). 4d8 Energy'
      )
    ]
  ),
  CreatureClass(
    id: 'mighty',
    name: 'Mighty',
    category: CreatureClassCategory.martial,
    drBonus: 65,
    shpBonus: 140,
    dhpBonus: 140,
    staminaBonus: 35,
    physicalDefenseBonus: 16,
    energyDefenseBonus: 14,
    heatDefenseBonus: 12,
    chillDefenseBonus: 12,
    psycheDefenseBonus: 10,
    powerBonus: 15,
    speedBonus: 10,
    fortitudeBonus: 10,
    dexterityBonus: 8,
    resolveBonus: 7,
    awarenessBonus: 7,
    portrayalBonus: 2,
    stuntBonus: 2,
    appealBonus: 2,
    languageBonus: 2,
    dodgeBonusDice: 4,
    blockBonusDice: 8,
    passives: [
      'This creature has 9 turn actions and 3 interrupt actions per turn.',
      'When a melee attack this creature makes deals enough damage to reduce its target’s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.',
      'When this creature makes a melee attack, it may choose to target each creature within the attack’s range rather than a single target. Attacks made this way deal half damage to each creature.',
      'When this creature takes the Travel action, it may spend 3 stamina to add its Power score to its Land travel for the rest of the action.',
      'Whenever another creature that this one can sense takes the Attack action, this creature may spend 8 stamina to take the Attack action using interrupt actions as if they were turn actions.',
      'When this creature makes an attack, it may spend 3 stamina to reduce the number of turn actions required by 1, minimum of 4 turn actions. It may also spend 5 stamina to do the same with a minimum of 2 turn actions, or 7 stamina with a minimum of 1 turn action. It may do so any number of times per attack.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack (Melee)',
        description: '6 Turn Actions. 2 meters (Melee). 7d10 + [Power Modifier] Physical, ignores defenses'
      ),
      CreatureAction(
        name: 'Attack (Ranged)',
        description: '2 Turn Actions. 10/20 meters (Ranged). 3d10 Physical + 4d8 Energy'
      )
    ]
  ),

  // Arcane
  CreatureClass(
    id: 'illusionist',
    name: 'Illusionist',
    category: CreatureClassCategory.arcane,
    drBonus: 7,
    staminaBonus: 35,
    resolveBonus: 7,
    passives: [
      'It can cast and craft spells using the Art of Array, Enchantment, and Illusion.',
      'Spells this creature casts cost 2 less stamina, minimum cost of 1.'
    ]
  ),
  CreatureClass(
    id: 'elemancer',
    name: 'Elemancer',
    category: CreatureClassCategory.arcane,
    drBonus: 12,
    staminaBonus: 60,
    speedBonus: 2,
    dexterityBonus: 2,
    resolveBonus: 8,
    passives: [
      'It can cast and craft spells using the Art of Evocation, Array, Wake, and Enchantment.',
      'Spells this creature casts cost 5 less stamina, minimum cost of 1.',
      'Its Spellcap is equal to its Will score.'
    ]
  ),
  CreatureClass(
    id: 'necromancer',
    name: 'Necromancer',
    category: CreatureClassCategory.arcane,
    drBonus: 12,
    staminaBonus: 60,
    resolveBonus: 6,
    awarenessBonus: 6,
    passives: [
      'It can cast and craft spells using the Art of Array, Wake, and Necromancy.',
      'Spells this creature casts cost 4 less stamina, minimum cost of 1.',
      'Its Spellcap is equal to its Will score.'
    ]
  ),
  CreatureClass(
    id: 'mystic',
    name: 'Mystic',
    category: CreatureClassCategory.arcane,
    drBonus: 24,
    dhpBonus: 20,
    staminaBonus: 100,
    resolveBonus: 9,
    awarenessBonus: 9,
    speedBonus: 2,
    dexterityBonus: 2,
    fortitudeBonus: 2,
    passives: [
      'It can cast and craft spells using the Art of Array, Wake, Enchantment, Illusion, Divination, and Alteration.',
      'When this creature is the target of any effect, it may spend 2 interrupt actions to cast a spell. Spells cast this way cost twice as much stamina before discounts.',
      'Spells this creature casts cost 8 less stamina, minimum cost of 1.',
      'Its Spellcap is equal to double its Will score.'
    ]
  ),
  CreatureClass(
    id: 'spitter',
    name: 'Spitter',
    category: CreatureClassCategory.arcane,
    drBonus: 30,
    shpBonus: 30,
    staminaBonus: 30,
    dhpBonus: 65,
    physicalDefenseBonus: 4,
    energyDefenseBonus: 4,
    heatDefenseBonus: 4,
    chillDefenseBonus: 4,
    psycheDefenseBonus: 4,
    speedBonus: 3,
    fortitudeBonus: 3,
    resolveBonus: 3,
    awarenessBonus: 3,
    dexterityBonus: 10,
    powerBonus: 2,
    portrayalBonus: 4,
    appealBonus: 1,
    languageBonus: 1,
    dodgeBonusDice: 4,
    passives: [
      'Ranged attacks this creature makes have twice as much close range.',
      'When this creature makes a ranged attack, it may choose 3 targets instead of 1. If it does, each target is dealt half damage instead, rounded up.',
      'This creature’s Land travel is equal to its Speed score plus 4.'
    ]
  ),

  // Support
  CreatureClass(
    id: 'healer',
    name: 'Healer',
    category: CreatureClassCategory.support,
    drBonus: 13,
    dhpBonus: 5,
    staminaBonus: 60,
    physicalDefenseBonus: 4,
    psycheDefenseBonus: 2,
    energyDefenseBonus: 1,
    heatDefenseBonus: 1,
    chillDefenseBonus: 1,
    engineeringBonus: 3,
    resolveBonus: 9,
    appealBonus: 1,
    languageBonus: 1,
    blockBonusDice: 2,
    passives: [
      'Whenever a creature within 5 meters makes a test, this creature may spend an interrupt action and 10 stamina up to once per test. If it does, its modifiers are added to the test.',
      'This creature has a number of Restoration Charges equal to its Resolve score.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 1 meter (Melee). 4d8 Physical damage.'
      ),
      CreatureAction(
        name: 'Special (Appeal)',
        description: '3 Turn Actions. This creature makes an Appeal test and chooses one between SHP and stamina. For each creature it chooses that can sense and understand it, if the test was higher than the amount missing for the chosen stat, it regains 1d6.'
      ),
      CreatureAction(
        name: 'Special (Restore)',
        description: '3 Turn Actions. This creature spends any number of Restoration Charges to heal a touching creature. It either heals 1d4 SHP per Restoration Charge or 1d4 DHP per 2 Restoration Charges used.'
      )
    ]
  ),

  // Innate
  CreatureClass(
    id: 'skyborn',
    name: 'Skyborn',
    category: CreatureClassCategory.innate,
    drBonus: 2,
    staminaBonus: 10,
    stuntBonus: 2,
    passives: [
      'Its Air travel becomes equal to its Speed score, its Land travel becomes equal to half its Speed score, rounded up.'
    ]
  ),
  CreatureClass(
    id: 'seaborn',
    name: 'Seaborn',
    category: CreatureClassCategory.innate,
    drBonus: 3,
    shpBonus: 5,
    dhpBonus: 5,
    staminaBonus: 5,
    speedBonus: 1,
    fortitudeBonus: 2,
    blockBonusDice: 1,
    passives: [
      'Its Water travel becomes equal to double its Speed score.',
      'This creature is able to breathe in both air and water.'
    ]
  ),
  CreatureClass(
    id: 'untouchable',
    name: 'Untouchable',
    category: CreatureClassCategory.innate,
    drBonus: 25,
    shpBonus: 50,
    dhpBonus: 50,
    staminaBonus: 25,
    energyDefenseBonus: 4,
    heatDefenseBonus: 4,
    chillDefenseBonus: 4,
    speedBonus: 3,
    dexterityBonus: 3,
    powerBonus: 3,
    fortitudeBonus: 3,
    engineeringBonus: 3,
    memoryBonus: 3,
    resolveBonus: 3,
    awarenessBonus: 3,
    portrayalBonus: 3,
    stuntBonus: 3,
    appealBonus: 3,
    languageBonus: 3,
    passives: [
      'This creature ignores all Physical damage dealt to it.'
    ]
  ),
];
