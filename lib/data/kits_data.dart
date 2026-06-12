import '../models/kit.dart';

const List<Kit> kitsData = [
  Kit(
    id: 'defensive',
    name: 'Defensive',
    drBonus: 2,
    bmsStatsBonus: {'shp': 5, 'dhp': 5},
    defenseBonus: {'choice': 4},
    ratingsBonus: {'choice': 1}
  ),
  Kit(
    id: 'impressive',
    name: 'Impressive',
    drBonus: 3,

    bmsStatsBonus: {'choice': 15},
    subtraitBonus: {'choice': 6}
  ),
  Kit(
    id: 'tank',
    name: 'Tank',
    drBonus: 4,
    bmsStatsBonus: {'shp': 10, 'dhp': 10},
    defenseBonus: {'physical': 3, 'energy': 3, 'heat': 1,
    'chill': 1, 'psyche': 1},
    subtraitBonus: {'power': 1, 'fortitude': 3},
    ratingsBonus: {'block': 1},
  ),
  Kit(
    id: 'rogue',
    name: 'Rogue',
    drBonus: 4,
    bmsStatsBonus: {'shp': 5, 'dhp': 5, 'stamina': 10},
    subtraitBonus: {'speed': 2, 'dexterity': 2},
    ratingsBonus: {'dodge': 1},
    travelBonus: {'land': 2},
    passives: [
      'This creature gains an additional point of favor on tests made to resist spell effects.',
    ],
  ),
  Kit(
    id: 'aggressive',
    name: 'Aggressive',
    drBonus: 4,
    bmsStatsBonus: {'dhp': 5, 'stamina': 15},
    subtraitBonus: {'dexterity': 1, 'power': 3},
    travelBonus: {'land': 2},
    passives: [
      'When this creature takes the Travel action, this creature may spend 3 times X stamina, whereas X is the number of stacks of this kit the creature has. If it does, its Land travel increases by its Power times X for the rest of the action.',
      'When this creature makes an Attack, it may spend double X turn actions and spend 12 times X stamina. If it does, it instead attacks a target at random and deals X times as much damage, whereas X is the number of stacks of this kit it has.',
    ],
  ),
  Kit(
    id: 'magus',
    name: 'Magus',
    drBonus: 4,
    bmsStatsBonus: {'stamina': 20},
    subtraitBonus: {'resolve': 4},
    passives: [
      'The cost of spells this creature casts are reduced by an additional 3 stamina, minimum of 1.',
    ],
  ),
  Kit(
    id: 'doppelganger',
    name: 'Doppelganger',
    drBonus: 6,
    bmsStatsBonus: {'shp': 5, 'dhp': 20, 'stamina': 5},
    defenseBonus: {'physical': 1, 'heat': 1, 'chill': 1,
    'energy': 1, 'psyche': 1},
    subtraitBonus: {'stunt': 1, 'portrayal': 2, 'appeal': 2,
    'language': 2},
    passives: [
      'This creature gains 2 additional points of favor on tests made to disguise itself or keep its identity unknown, as well as 2 additional points of favor on tests made to mimic the actions of another creature.',
    ],
  ),
  Kit(
    id: 'powerful',
    name: 'Powerful',
    drBonus: 20,
    bmsStatsBonus: {'shp': 40, 'dhp': 40, 'stamina': 20},
    defenseBonus: {'physical': 12, 'energy': 10, 'heat': 9, 'chill': 9, 'psyche': 5},
    subtraitBonus: {'portrayal': 1, 'stunt': 1, 'appeal': 1, 'language': 2, 'speed': 2, 'dexterity': 2,
    'power': 2, 'fortitude': 2, 'engineering': 2, 'memory': 2, 'resolve': 2, 'awareness': 2},
    ratingsBonus: {'block': 2, 'dodge': 2},
    passives: [
      'This creature gains an additional point of favor on tests made to resist spell effects.',
    ],
  ),
];
