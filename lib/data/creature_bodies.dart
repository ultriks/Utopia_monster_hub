import '../models/creature_body.dart';
import '../models/action.dart';

const List<CreatureBody> creatureBodies = [
  CreatureBody(
    type: CreatureBodyType.elemental,
    name: 'Elemental',
    baseDr: 17,
    bmsStats: const {'shp': 20, 'dhp': 45, 'stamina': 20},
    defenses: const {'physical': 5},
    subtraits: const {'speed': 4, 'dexterity': 3, 'awareness': 5, 'portrayal': 5, 'stunt': 2, 'appeal': 4},
    ratings: const {'dodge': "4d12", 'block': "1d4"},
    passives: const [
      'This creature does not need to breathe, eat, drink water, or sleep. It cannot be inflicted with points of Fatigue or Unconsciousness.',
      'This creature hovers above the ground up to 1 meters and ignores damage dealt from falling and can levitate above liquids as if it was solid ground. Its Land travel is equal to its Speed score plus 2.',
      'This creature’s Land travel cannot be reduced.',
      'This creature ignores Energy/Heat/Chill damage.'
    ],
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 5/10 meters (Ranged). 2d8 + [Portrayal Mod] Energy/Heat/Chill damage. This creature may spend up to 3 additional turn actions, dealing an additional 2d8 damage of the same type per additional turn action.'
      )
    ],
    harvest: const [
      'Upon succeeding a Resolve test, 1d8 power components will be harvested. The test’s TD is equal to a fifth of its DR, rounded up.'
    ]
  ),
  CreatureBody(
    type: CreatureBodyType.beast,
    name: 'Beast',
    baseDr: 5,
    bmsStats: const {'shp': 10, 'dhp': 5, 'stamina': 10},
    defenses: const {'physical': 1, 'energy': 1, 'heat': 1, 'chill': 1, 'psyche': 1},
    subtraits: const {'speed': 2, 'dexterity': 2, 'power': 2, 'awareness': 3},
    ratings: const {'dodge': "3d12", 'block': "2d4"},
    passives: const [
      'When this creature becomes the target of an effect, it may spend 3 stamina to take the Travel action using interrupt actions as if they were turn actions.'
    ],
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 0 meters (Melee). 2d8 + [Power Mod] Physical damage.'
      )
    ],
    harvest: const [
      '1d6 material components',
      'Upon succeeding an Engineering test, 1d8 material components and 1d4 refinement components will be harvested. The test’s TD is equal to a fifth of its DR, rounded up.'
    ]
  ),
  CreatureBody(
    type: CreatureBodyType.humanoid,
    name: 'Humanoid',
    baseDr: 5,
    bmsStats: const {'shp': 10, 'dhp': 10, 'stamina': 5},
    defenses: const {'physical': 1, 'energy': 1, 'heat': 1, 'chill': 1, 'psyche': 1},
    subtraits: const {'speed': 2, 'dexterity': 2, 'power': 2, 'engineering': 2, 'memory': 2, 'awareness': 2, 'portrayal': 2, 'language': 2},
    ratings: const {'dodge': "2d12", 'block': "2d4"},
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 0 meters (Melee). 1d8 + [Power Mod] Physical damage. This creature may spend up to 3 additional turn actions, dealing an additional 2d8 Physical damage per additional turn action.'
      )
    ],
    harvest: const [
      '1d4 Crude material components',
      'Upon succeeding an Engineering test, 1d4 refinement components will be harvested. The test’s TD is equal to a tenth of its DR, rounded up.'
    ]
  ),
  CreatureBody(
    type: CreatureBodyType.construct,
    name: 'Construct',
    baseDr: 5,
    bmsStats: const {'shp': 15, 'dhp': 5, 'stamina': 5},
    defenses: const {'physical': 2, 'energy': 2, 'chill': 1},
    subtraits: const {'speed': 2, 'power': 2, 'fortitude': 4, 'resolve': 2},
    ratings: const {'dodge': "2d12", 'block': "2d4"},
    passives: const [
      'This creature does not need to breathe, eat, drink water, or sleep. It cannot be inflicted with points of Fatigue or Unconsciousness.',
      'If this creature is being controlled by a caster, it ignores Psyche damage dealt to it. Instead, Psyche damage is dealt to the caster.'
    ],
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 0 meters (Melee). 1d8 + [Power Mod] Physical damage. This creature may spend up to 3 additional turn actions, dealing an additional 2d8 Physical damage per additional turn action.'
      )
    ],
    harvest: const [
      '1d4 material components',
      'Upon succeeding an Engineering test, 1d10 material components and 1d4 power components will be harvested. The test’s TD is equal to a tenth of its DR, rounded up. If this creature was created due to a spell, its harvestable component rarity and quantities cannot be higher than those used to create it.'
    ]
  ),
  CreatureBody(
    type: CreatureBodyType.draconic,
    name: 'Draconic',
    baseDr: 50,
    bmsStats: const {'shp': 90, 'dhp': 90, 'stamina': 70},
    defenses: const {'physical': 21, 'energy': 11, 'heat': 11, 'chill': 11, 'psyche': 11},
    subtraits: const {'speed': 4, 'dexterity': 3, 'power': 10, 'fortitude': 10, 'resolve': 8, 'awareness': 5, 'portrayal': 6, 'language': 4, 'appeal': 3, 'engineering': 3, 'memory': 3, 'stunt': 3},
    ratings: const {'dodge': "4d12", 'block': "8d4"},
    passives: const [
      'When this creature becomes the target of an effect, it may spend 3 stamina to take the Travel action using interrupt actions as if they were turn actions.',
      'A source of kinetic force cannot deal more damage to this creature than half of its maximum DHP, rounded down.',
      'When this creature takes the Block action against a melee attack, it may spend 1 additional interrupt action and 5 stamina to roll a melee attack instead of its Block Rating.',
      'This creature ignores Energy/Heat/Chill damage.'
    ],
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 2 meters (Melee). 6d12 + [Power Mod] Physical damage.'
      ),
      CreatureAction(
        name: 'Breath Attack',
        description: '3 Turn Actions, 10 stamina. 8d8 Energy/Heat/Chill damage. This attack affects all creatures within a 90 degree cone, originating from this creature, extending out to 10 meters.'
      )
    ],
    harvest: const [
      '1d4 material components',
      'Upon succeeding an Engineering test, 1d10 material components, 1d8 refinement components, and 1d6 power components will be harvested. The test’s TD is equal to a fifth of its DR, rounded up.'
    ]
  ),
  CreatureBody(
    type: CreatureBodyType.abomination,
    name: 'Abomination',
    baseDr: 3,
    bmsStats: const {'shp': 5, 'dhp': 5, 'stamina': 5},
    defenses: const {'physical': 5, 'psyche': 1, 'energy': 3, 'heat': 3, 'chill': 3},
    subtraits: const {'dexterity': 2, 'power': 2, 'fortitude': 2},
    ratings: const {'dodge': "1d12", 'block': "1d4"},
    actions: const [
      CreatureAction(
        name: 'Attack',
        description: '2 Turn Actions. 0 meters (Melee). 1d8 Physical damage.'
      )
    ],
    harvest: const [
      '1d6 material components',
      'Upon succeeding an Engineering test, 1d10 material components, 1d10 refinement components, and 1d10 power components will be harvested. The test’s TD is equal to half its DR, rounded up.'
    ]
  ),
];
