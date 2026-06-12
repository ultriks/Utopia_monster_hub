import '../models/creature_class.dart';
import '../models/action.dart';

final List<CreatureClass> classesData = [
  // Martial
  CreatureClass(
    id: 'brute',
    name: 'Brute',
    category: CreatureClassCategory.martial,
    drBonus: 8,
    bmsStatsBonus: {'shp': 25, 'dhp': 15},
    defenseBonus: {'physical': 2, 'energy': 1, 'heat': 1, 'chill': 1},
    subtraitBonus: {'power': 4, 'speed': 2, 'fortitude': 2},
    ratingsBonus: {'block': 1},
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
    bmsStatsBonus: {'shp': 35, 'dhp': 30, 'stamina': 10},
    defenseBonus: {'physical': 4, 'energy': 2, 'heat': 2, 'chill': 2},
    subtraitBonus: {'dexterity': 5, 'power': 5, 'speed': 3, 'fortitude': 2},
    ratingsBonus: {'dodge': 2, 'block': 2},
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
    bmsStatsBonus: {'shp': 70, 'dhp': 60, 'stamina': 20},
    defenseBonus: {'physical': 7, 'energy': 5, 'heat': 4, 'chill': 4},
    subtraitBonus: {'dexterity': 8, 'power': 8, 'speed': 6, 'fortitude': 4, 'resolve': 4},
    ratingsBonus: {'dodge': 3, 'block': 4},
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
    bmsStatsBonus: {'shp': 140, 'dhp': 140, 'stamina': 35},
    defenseBonus: {'physical': 16, 'energy': 14, 'heat': 12, 'chill': 12, 'psyche': 10},
    subtraitBonus: {'power': 15, 'speed': 10, 'fortitude': 10, 'dexterity': 8, 'resolve': 7, 
    'awareness': 7, 'portrayal': 2, 'stunt': 2, 'appeal': 2, 'language': 2},
    ratingsBonus: {'dodge': 4, 'block': 8},
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
    bmsStatsBonus: {'stamina': 35, 'resolve': 7},
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
    bmsStatsBonus: {'stamina': 60},
    subtraitBonus: {'speed': 2, 'dexterity': 2, 'resolve': 8},
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
    bmsStatsBonus: {'stamina': 60},
    subtraitBonus: {'resolve': 6, 'awareness': 6},
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
    bmsStatsBonus: {'dhp': 20, 'stamina': 100},
    subtraitBonus: {'resolve': 9, 'awareness': 9, 'speed': 2, 'dexterity': 2, 'fortitude': 2},
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
    bmsStatsBonus: {'shp': 30, 'dhp': 65},
    defenseBonus: {'physical': 4, 'energy': 4, 'heat': 4, 'chill': 4, 'psyche': 4},
    subtraitBonus: {'speed': 3, 'dexterity': 10, 'power': 2, 'fortitude': 3,
    'resolve': 3, 'awareness': 3, 'portrayal': 4, 'appeal': 1, 'language': 1},
    ratingsBonus: {'dodge': 4},
    travelBonus: {'land': 4},
    passives: [
      'Ranged attacks this creature makes have twice as much close range.',
      'When this creature makes a ranged attack, it may choose 3 targets instead of 1. If it does, each target is dealt half damage instead, rounded up.',
      'This creature’s Land travel is equal to its Speed score plus 4.(it is already calculated into the sheet)'
    ]
  ),

  // Support
  CreatureClass(
    id: 'healer',
    name: 'Healer',
    category: CreatureClassCategory.support,
    drBonus: 13,
    bmsStatsBonus: {'dhp': 5, 'stamina': 60},
    defenseBonus: {'physical': 4, 'psyche': 2, 'heat': 1, 'chill': 1, 'energy': 1},
    subtraitBonus: {'engineering': 3, 'resolve': 9, 'appeal': 1, 'language': 1},
    ratingsBonus: {'block': 2},
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
    bmsStatsBonus: {'stamina': 10},
    subtraitBonus: {'stunt': 2},
    passives: [
      'Its Air travel becomes equal to its Speed score, its Land travel becomes equal to half its Speed score, rounded up.'
    ]
  ),
  CreatureClass(
    id: 'seaborn',
    name: 'Seaborn',
    category: CreatureClassCategory.innate,
    drBonus: 3,
    bmsStatsBonus: {'shp': 5, 'dhp': 5},
    subtraitBonus: {'speed': 1, 'fortitude': 2},
    ratingsBonus: {'block': 1},
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
    bmsStatsBonus: {'shp': 50, 'dhp': 50, 'stamina': 25},
    defenseBonus: {'energy': 4, 'heat': 4, 'chill': 4},
    subtraitBonus: {'speed': 3, 'dexterity': 3, 'power': 3, 'fortitude': 3, 
    'engineering': 3, 'memory': 3, 'resolve': 3, 'awareness': 3, 'portrayal': 3,
    'stunt': 3, 'appeal': 3, 'language': 3},
    passives: [
      'This creature ignores all Physical damage dealt to it.'
    ]
  ),
];
