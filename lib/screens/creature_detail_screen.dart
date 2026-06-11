import 'package:flutter/material.dart';
import '../models/creature.dart';
import '../models/action.dart';
import '../data/kits_data.dart';
import '../data/classes_data.dart';
import '../utils/constants.dart';

class CreatureDetailScreen extends StatelessWidget {
  final Creature creature;

  const CreatureDetailScreen({super.key, required this.creature});

  @override
  Widget build(BuildContext context) {
    // Resolve kit names from stored JSON
    final List<_KitDisplay> kitDisplays = [];
    for (var kitEntry in creature.kits) {
      final kitId = kitEntry['kitId'] as String?;
      final stacks = kitEntry['stacks'] as int? ?? 1;
      if (kitId != null) {
        final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
        kitDisplays.add(_KitDisplay(
          name: kit?.name ?? kitId,
          stacks: stacks,
        ));
      }
    }

    // Resolve class names from stored JSON
    final List<String> classNames = creature.classes.map((classId) {
      final cls = classesData.where((c) => c.id == classId).firstOrNull;
      return cls?.name ?? classId;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(creature.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Редагування не буде, пішов ти нахуй')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Body type
            Text(
              "Body Type: ${creature.bodyType.name.toUpperCase()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            if (creature.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(creature.description, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Combat values row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statColumn("DR", creature.finalDr, AppColors.primary),
                _statColumn("SHP", creature.shp, AppColors.heal),
                _statColumn("DHP", creature.dhp, AppColors.error),
                _statColumn("STAMINA", creature.stamina, Colors.blue),
              ],
            ),

            // Stats row
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               _statColumn("AGILITY", creature.speed+creature.dexterity, AppColors.bodyTraits),
               _statColumn("STRENGTH", creature.power+creature.fortitude, AppColors.bodyTraits),
               _statColumn("INTELLECT", creature.engineering+creature.memory, AppColors.mindTraits),
               
              ]
            ), //TODO: Rewrite the code so it uses the same methods as kits */

            // Kits section
            if (kitDisplays.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Kits'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: kitDisplays.map((kd) {
                  return Chip(
                    label: Text(kd.stacks > 1 ? '${kd.name} ×${kd.stacks}' : kd.name),
                    backgroundColor: AppColors.surface,
                  );
                }).toList(),
              ),
            ],

            // Classes section
            if (classNames.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Classes'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: classNames.map((name) {
                  return Chip(
                    label: Text(name),
                    backgroundColor: AppColors.surface,
                  );
                }).toList(),
              ),
            ],

            // Actions section
            if (creature.actions.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Actions'),
              const SizedBox(height: 8),
              ...creature.actions.map((action) => _actionTile(action)),
            ],

            // Passives section
            if (creature.passives.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Passives & Features'),
              const SizedBox(height: 8),
              ...creature.passives.map((passive) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppColors.primary, fontSize: 16)),
                    Expanded(child: Text(passive, style: const TextStyle(fontSize: 14))),
                  ],
                ),
              )),
            ],

            // Tags section
            if (creature.tags.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Tags'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: creature.tags.map((tag) {
                  return Chip(
                    label: Text(tag.name),
                    backgroundColor: tag.color != null ? Color(tag.color!) : AppColors.surface,
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _statColumn(String label, int value, Color color) {
    return Column(
      children: [
        Text(value.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _actionTile(CreatureAction action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.flash_on, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(action.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(action.description, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KitDisplay {
  final String name;
  final int stacks;
  const _KitDisplay({required this.name, required this.stacks});
}
