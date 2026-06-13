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
    consumable,
    artifacts
}

Class Item {
    final String name;
    final String description;
    final Rarity rarity;
    final ItemType type;
    final int cost;
    final Map<String, int> components;

    const Item({
        required this.name,
        required this.rarity,
        required this.type,
        required this.description,

        this.cost = const 0,
        this.components = const {'material': 0, 'refinement': 0, 'power': 0 },
    });
}