enum Rarity {
    crude,
    common,
    extraordinary,
    rare,
    legendary,
    mythical
}

enum ItemType{
    weapon,
    armour,
    shield,
    consumable,
    artifact
}

abstract class Item {
    final String id;
    final String name;
    final String description;
    final Rarity rarity;
    final ItemType type;
    final int cost;
    final int slots_taken;
    final Map<String, int> components;

    const Item({
        required this.id,
        required this.name,
        required this.rarity,
        required this.type,
        required this.description,
        this.cost = 0,
        this.slots_taken = 0,
        this.components = const {'material': 0, 'refinement': 0, 'power': 0 },
    });

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'name': name,
            'description': description,
            'rarity': rarity.name,
            'type': type.name,
            'cost': cost,
            'components': components,
            'slots_taken': slots_taken,
        };
    }

    factory Item.fromMap(Map<String, dynamic> map) {
        return Item(
            id: map['id'],
            name: map['name'],
            description: map['description'] ?? '',
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.artifact,
            ),
            cost: map['cost'] ?? 0,
            slots_taken: map['slots_taken'] ?? 0,
            components: Map<String, int>.from(map['components'] ?? {'material': 0, 'refinement': 0, 'power': 0}),
        );
    }
}

enum DamageType{
    physical,
    energy,
    heat,
    chill,
    psyche
}

class Weapon extends Item {
    final int TA;
    final (int amount, int dice_sides) damage;
    final DamageType damageType;
    final record (int, int?) range;
    final int? staminaCost;
    final int? shpCost;
    

    Weapon({
        required super.id,
        required super.name,
        required super.rarity,
        required super.type,
        required super.description,
        required super.cost,
        required super.slots_taken,
        required super.components,
        required this.TA,
        this.damage = (0, 0),
        required this.damageType,
        this.range = (0, null),
        this.staminaCost,
        this.shpCost,
    });

    @override
    Map<String, dynamic> toMap() {
        return {
            ...super.toMap(),
            'TA': TA,
            'damage': damage,
            'damageType': damageType.name,
            'range': range,
            'staminaCost': staminaCost,
            'shpCost': shpCost
        };
    }

    factory Weapon.fromMap(Map<String, dynamic> map) {
        return Weapon(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.artifact,
            ),
            cost: map['cost'],
            slots_taken: map['slots_taken'],
            components: Map<String, int>.from(map['components']),
            TA: map['TA'],
            damage: record.fromMap(map['damage']),
            damageType: DamageType.values.firstWhere(
                (e) => e.name == map['damageType'],
                orElse: () => DamageType.physical,
            ),
            range: record.fromMap(map['range']),
            staminaCost: map['staminaCost'],
            shpCost: map['shpCost']
        );
    }
}

enum ArmourSlot {
    chest,
    head,
    hand,
    foot
}
class Armour extends Item {
    final ArmourSlot slot;
    final Map<String, int> defenseBonus;
    final Map<String, int> ratingsBonus;
    Armour({
        required super.id,
        required super.name,
        required super.rarity,
        required super.type,
        required super.description,
        required super.cost,
        required super.slots_taken,
        required super.components,
        required this.slot,
        this.defenseBonus = const {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0},
        this.ratingsBonus = const {'block': 0, 'dodge': 0}
    });
    @override
    Map<String, dynamic> toMap() {
        return {
            ...super.toMap(),
            'slot': slot.name,
            'ratingsBonus': ratingsBonus,
            'defenseBonus': defenseBonus,
        };
    }
    factory Armour.fromMap(Map<String, dynamic> map) {
        return Armour(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.armour,
            ),
            cost: map['cost'],
            slots_taken: map['slots_taken'],
            components: Map<String, int>.from(map['components']),
            slot: ArmourSlot.values.firstWhere(
                (e) => e.name == map['slot'],
                orElse: () => ArmourSlot.chest,
            ),
            defenseBonus: Map<String, int>.from(map['defenseBonus'] ?? {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0}),
            ratingsBonus: Map<String, int>.from(map['ratingsBonus'] ?? {'block': 0, 'dodge': 0}),
        );
    }
}
class Shield extends Item {
    final Map<String, int> defenseBonus;
    final Map<String, int> ratingsBonus;
    Shield({
        required super.id,
        required super.name,
        required super.rarity,
        required super.type,
        required super.description,
        required super.cost,
        required super.slots_taken,
        required super.components,
        this.defenseBonus = const {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0},
        this.ratingsBonus = const {'block': 0, 'dodge': 0}
    });
    @override
    Map<String, dynamic> toMap() {
        return {
            ...super.toMap(),
            'defenseBonus': defenseBonus,
            'ratingsBonus': ratingsBonus,
        };
    }
    factory Shield.fromMap(Map<String, dynamic> map) {
        return Shield(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.shield,
            ),
            cost: map['cost'],
            slots_taken: map['slots_taken'],
            components: Map<String, int>.from(map['components']),
            defenseBonus: Map<String, int>.from(map['defenseBonus'] ?? {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0}),
            ratingsBonus: Map<String, int>.from(map['ratingsBonus'] ?? {'block': 0, 'dodge': 0}),
        );
    }
}
class Consumable extends Item {
    final int doses;
    final int TA;
    Consumable({
        required super.id,
        required super.name,
        required super.rarity,
        required super.type,
        required super.description,
        required super.cost,
        required super.slots_taken,
        required super.components,
        this.doses = 1,
        this.TA = 2,
    });
    @override
    Map<String, dynamic> toMap() {
        return {
            ...super.toMap(),
            'doses': doses,
            'TA': TA,
        };
    }
    factory Consumable.fromMap(Map<String, dynamic> map) {
        return Consumable(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.consumable,
            ),
            cost: map['cost'],
            slots_taken: map['slots_taken'],
            components: Map<String, int>.from(map['components']),
            doses: map['doses'] ?? 1,
            TA: map['TA'] ?? 2,
        );
    }
}
enum ArtifactSlot {
    neck,
    ring,
    back,
    waist,
    handheld,
    ammunition,
    none
}
class Artifact extends Item {
    final ArtifactSlot slot;
    final int TA;
    Artifact({
        required super.id,
        required super.name,
        required super.rarity,
        required super.type,
        required super.description,
        required super.cost,
        required super.slots_taken,
        required super.components,
        required this.slot,
        this.TA = 0,
    });
    @override
    Map<String, dynamic> toMap() {
        return {
            ...super.toMap(),
            'slot': slot.name,
            'TA': TA,
        };
    }
    factory Artifact.fromMap(Map<String, dynamic> map) {
        return Artifact(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            rarity: Rarity.values.firstWhere(
                (e) => e.name == map['rarity'],
                orElse: () => Rarity.crude,
            ),
            type: ItemType.values.firstWhere(
                (e) => e.name == map['type'],
                orElse: () => ItemType.artifact,
            ),
            cost: map['cost'],
            slots_taken: map['slots_taken'],
            components: Map<String, int>.from(map['components']),
            slot: ArtifactSlot.values.firstWhere(
                (e) => e.name == map['slot'],
                orElse: () => ArtifactSlot.none,
            ),
            TA: map['TA'] ?? 0,
        );
    }
}