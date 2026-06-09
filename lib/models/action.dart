class CreatureAction {
  final String name;
  final String description;

  const CreatureAction({
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory CreatureAction.fromMap(Map<String, dynamic> map) {
    return CreatureAction(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
