import '../models/creature_class.dart';
import '../models/action.dart';
import 'items_data.dart' as items;

final List<CreatureClass> classesData = [
  // Martial
  CreatureClass(
    id: 'brute',
    name: 'Brute',
    category: CreatureClassCategory.martial,
    drBonus: 8,
    bmsStatsBonus: {'shp': 25, 'dhp': 15, 'stamina': 0, 'choice': 0},
    defenseBonus: {'physical': 2, 'energy': 1, 'heat': 1, 'chill': 1, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 2, 'dexterity': 0, 'power': 4, 'fortitude': 2,
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 1, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target\u2019s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.'
    ],
    actions: [
      CreatureAction(
        name: 'Attack',
        description: '1 Turn Action. 0 meters (Melee). 4d4 Physical damage.'
      )
    ],
    items: [
      items.itemsData.firstWhere((i) => i.id == 'dagger_01'),
      items.itemsData.firstWhere((i) => i.id == 'garments_01'),
    ]
  ),
  CreatureClass(
    id: 'martialist',
    name: 'Martialist',
    category: CreatureClassCategory.martial,
    drBonus: 15,
    bmsStatsBonus: {'shp': 35, 'dhp': 30, 'stamina': 10, 'choice': 0},
    defenseBonus: {'physical': 4, 'energy': 2, 'heat': 2, 'chill': 2, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 3, 'dexterity': 5, 'power': 5, 'fortitude': 2,
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 2, 'dodge': 2, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target\u2019s DHP to 0, it may retarget the remaining damage to another creature within range.',
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
    ],
    items: [
      items.itemsData.firstWhere((i) => i.id == 'claymore_01'),
      items.itemsData.firstWhere((i) => i.id == 'longbow_01'),
      items.itemsData.firstWhere((i) => i.id == 'body_armor_01'),
    ]
  ),
  CreatureClass(
    id: 'militant',
    name: 'Militant',
    category: CreatureClassCategory.martial,
    drBonus: 30,
    bmsStatsBonus: {'shp': 70, 'dhp': 60, 'stamina': 20, 'choice': 0},
    defenseBonus: {'physical': 7, 'energy': 5, 'heat': 4, 'chill': 4, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 6, 'dexterity': 8, 'power': 8, 'fortitude': 4,
    'engineering': 0, 'memory': 0, 'resolve': 4, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 4, 'dodge': 3, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'When a melee attack this creature makes deals enough damage to reduce its target\u2019s DHP to 0, it may retarget the remaining damage to another creature within range.',
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
    ],
    items: [
      items.itemsData.firstWhere((i) => i.id == 'force_arbalest_01'),
      items.itemsData.firstWhere((i) => i.id == 'power_body_01'),
      items.itemsData.firstWhere((i) => i.id == 'gauntlets_01'),
      items.itemsData.firstWhere((i) => i.id == 'force_blade_01'),
    ]
  ),
  CreatureClass(
    id: 'mighty',
    name: 'Mighty',
    category: CreatureClassCategory.martial,
    drBonus: 65,
    bmsStatsBonus: {'shp': 140, 'dhp': 140, 'stamina': 35, 'choice': 0},
    defenseBonus: {'physical': 16, 'energy': 14, 'heat': 12, 'chill': 12, 'psyche': 10, 'choice': 0},
    subtraitBonus: {'speed': 10, 'dexterity': 8, 'power': 15, 'fortitude': 10,
    'engineering': 0, 'memory': 0, 'resolve': 7, 'awareness': 7, 'portrayal': 2,
    'stunt': 2, 'appeal': 2, 'language': 2, 'choice': 0},
    ratingsBonus: {'block': 8, 'dodge': 4, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'This creature has 9 turn actions and 3 interrupt actions per turn.',
      'When a melee attack this creature makes deals enough damage to reduce its target\u2019s DHP to 0, it may retarget the remaining damage to another creature within range.',
      'This creature gains an additional point of favor on tests made to grapple.',
      'When this creature makes a melee attack, it may choose to target each creature within the attack\u2019s range rather than a single target. Attacks made this way deal half damage to each creature.',
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
    ],
    items: [
      items.itemsData.firstWhere((i) => i.id == 'tremor_hammer_01'),
      // items.itemsData.firstWhere((i) => i.id == 'shatter_gat_01'), // Currently commented out in items_data.dart
      items.itemsData.firstWhere((i) => i.id == 'imperial_chestpiece_01'),
      items.itemsData.firstWhere((i) => i.id == 'power_helm_01'),
      items.itemsData.firstWhere((i) => i.id == 'gauntlets_01'),
      items.itemsData.firstWhere((i) => i.id == 'greaves_01'),
    ]
  ),

  // Arcane
  CreatureClass(
    id: 'illusionist',
    name: 'Illusionist',
    category: CreatureClassCategory.arcane,
    drBonus: 7,
    bmsStatsBonus: {'shp': 0, 'dhp': 0, 'stamina': 35, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0,
    'engineering': 0, 'memory': 0, 'resolve': 7, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 0, 'dhp': 0, 'stamina': 60, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 2, 'dexterity': 2, 'power': 0, 'fortitude': 0,
    'engineering': 0, 'memory': 0, 'resolve': 8, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 0, 'dhp': 0, 'stamina': 60, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0,
    'engineering': 0, 'memory': 0, 'resolve': 6, 'awareness': 6, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 0, 'dhp': 20, 'stamina': 100, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 2, 'dexterity': 2, 'power': 0, 'fortitude': 2,
    'engineering': 0, 'memory': 0, 'resolve': 9, 'awareness': 9, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 30, 'dhp': 65, 'stamina': 0, 'choice': 0},
    defenseBonus: {'physical': 4, 'energy': 4, 'heat': 4, 'chill': 4, 'psyche': 4, 'choice': 0},
    subtraitBonus: {'speed': 3, 'dexterity': 10, 'power': 2, 'fortitude': 3,
    'engineering': 0, 'memory': 0, 'resolve': 3, 'awareness': 3, 'portrayal': 4,
    'stunt': 0, 'appeal': 1, 'language': 1, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 4, 'choice': 0},
    travelBonus: {'land': 4, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'Ranged attacks this creature makes have twice as much close range.',
      'When this creature makes a ranged attack, it may choose 3 targets instead of 1. If it does, each target is dealt half damage instead, rounded up.',
      'This creature\u2019s Land travel is equal to its Speed score plus 4.(it is already calculated into the sheet)'
    ]
  ),

  // Support
  CreatureClass(
    id: 'healer',
    name: 'Healer',
    category: CreatureClassCategory.support,
    drBonus: 13,
    bmsStatsBonus: {'shp': 0, 'dhp': 5, 'stamina': 60, 'choice': 0},
    defenseBonus: {'physical': 4, 'energy': 1, 'heat': 1, 'chill': 1, 'psyche': 2, 'choice': 0},
    subtraitBonus: {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0,
    'engineering': 3, 'memory': 0, 'resolve': 9, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 1, 'language': 1, 'choice': 0},
    ratingsBonus: {'block': 2, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 0, 'dhp': 0, 'stamina': 10, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0,
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 2, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'Its Air travel becomes equal to its Speed score, its Land travel becomes equal to half its Speed score, rounded up.'
    ]
  ),
  CreatureClass(
    id: 'seaborn',
    name: 'Seaborn',
    category: CreatureClassCategory.innate,
    drBonus: 3,
    bmsStatsBonus: {'shp': 5, 'dhp': 5, 'stamina': 0, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 1, 'dexterity': 0, 'power': 0, 'fortitude': 2,
    'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0,
    'stunt': 0, 'appeal': 0, 'language': 0, 'choice': 0},
    ratingsBonus: {'block': 1, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
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
    bmsStatsBonus: {'shp': 50, 'dhp': 50, 'stamina': 25, 'choice': 0},
    defenseBonus: {'physical': 0, 'energy': 4, 'heat': 4, 'chill': 4, 'psyche': 0, 'choice': 0},
    subtraitBonus: {'speed': 3, 'dexterity': 3, 'power': 3, 'fortitude': 3,
    'engineering': 3, 'memory': 3, 'resolve': 3, 'awareness': 3, 'portrayal': 3,
    'stunt': 3, 'appeal': 3, 'language': 3, 'choice': 0},
    ratingsBonus: {'block': 0, 'dodge': 0, 'choice': 0},
    travelBonus: {'land': 0, 'water': 0, 'air': 0, 'choice': 0},
    passives: [
      'This creature ignores all Physical damage dealt to it.'
    ]
  ),
];
