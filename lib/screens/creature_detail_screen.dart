import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/creature.dart';
import '../models/action.dart';
import '../data/kits_data.dart';
import '../data/classes_data.dart';
import '../data/items_data.dart';
import '../data/database_helper.dart';
import '../utils/constants.dart';
import 'creature_edit_screen.dart';

class CreatureDetailScreen extends StatelessWidget {
  final Creature creature;

  const CreatureDetailScreen({super.key, required this.creature});

  void _copyCreature(BuildContext context) async {
    final newCreature = Creature(
      id: const Uuid().v4(),
      name: '${creature.name} (Copy)',
      description: creature.description,
      bodyType: creature.bodyType,
      kits: List.from(creature.kits),
      classes: List.from(creature.classes),
      items: List.from(creature.items),
      customStats: Map.from(creature.customStats),
      actions: List.from(creature.actions),
      passives: List.from(creature.passives),
      finalDr: creature.finalDr,
      shp: creature.shp,
      dhp: creature.dhp,
      stamina: creature.stamina,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
      tags: List.from(creature.tags),
    );

    try {
      await DatabaseHelper.instance.createCreature(newCreature);
      if (context.mounted) {
        Navigator.pop(
          context,
          true,
        ); // Pop with true to indicate a refresh is needed
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error copying creature: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Resolve kit names from stored JSON
    final List<_KitDisplay> kitDisplays = [];
    for (var kitEntry in creature.kits) {
      final kitId = kitEntry['kitId'] as String?;
      final stacks = kitEntry['stacks'] as int? ?? 1;
      if (kitId != null) {
        final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
        kitDisplays.add(_KitDisplay(name: kit?.name ?? kitId, stacks: stacks));
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
            icon: const Icon(Icons.copy),
            tooltip: 'Copy Creature',
            onPressed: () => _copyCreature(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatureEditScreen(creature: creature),
                ),
              );
              if (result == true && context.mounted) {
                Navigator.pop(context, true); // Pop back to trigger refresh
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete thy creature',
            onPressed: () async {
              await DatabaseHelper.instance.deleteCreature(creature.id!);
              if (context.mounted) {
                Navigator.pop(context, true); // Pop back to trigger refresh
              }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Body Type: ${creature.bodyType.name.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  "XP: ${_calculateXP(creature)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.heal,
                  ),
                ),
              ],
            ),
            if (creature.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                creature.description,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
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

            _buildDefensesSection(creature),
            _buildTraitsSection(creature),

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
                    label: Text(
                      kd.stacks > 1 ? '${kd.name} ×${kd.stacks}' : kd.name,
                    ),
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
            if (creature.computedActions.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Actions'),
              const SizedBox(height: 8),
              ...creature.computedActions.map((action) => _actionTile(action)),
            ],

            // Passives section
            if (creature.computedPassives.isNotEmpty) ...[
              const SizedBox(height: 24),
              _sectionHeader('Passives & Features'),
              const SizedBox(height: 8),
              ...creature.computedPassives.map(
                (passive) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          passive,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    backgroundColor: tag.color != null
                        ? Color(tag.color!)
                        : AppColors.surface,
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
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
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
                Text(
                  action.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  action.description,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefensesSection(Creature creature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _sectionHeader('Defenses'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _defenseColumn(Icons.shield, creature.getDefense('physical')),
            _defenseColumn(Icons.electric_bolt, creature.getDefense('energy')),
            _defenseColumn(
              Icons.local_fire_department,
              creature.getDefense('heat'),
            ),
            _defenseColumn(Icons.ac_unit, creature.getDefense('chill')),
            _defenseColumn(Icons.psychology, creature.getDefense('psyche')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ratingColumn("Block", creature.getRating('block')),
            _ratingColumn("Dodge", creature.getRating('dodge')),
          ],
        ),
      ],
    );
  }

  Widget _defenseColumn(IconData icon, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        Icon(icon, size: 20, color: AppColors.onSurface),
      ],
    );
  }

  Widget _ratingColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTraitsSection(Creature creature) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _sectionHeader('Traits & Subtraits'),
        const SizedBox(height: 16),
        _buildTraitGroup(
          "AGILITY",
          creature.getSubtrait('speed') + creature.getSubtrait('dexterity'),
          AppColors.bodyTraits,
          "Speed",
          creature.getSubtrait('speed'),
          "Dexterity",
          creature.getSubtrait('dexterity'),
        ),
        _buildTraitGroup(
          "STRENGTH",
          creature.getSubtrait('power') + creature.getSubtrait('fortitude'),
          AppColors.bodyTraits,
          "Power",
          creature.getSubtrait('power'),
          "Fortitude",
          creature.getSubtrait('fortitude'),
        ),
        _buildTraitGroup(
          "INTELLECT",
          creature.getSubtrait('engineering') + creature.getSubtrait('memory'),
          AppColors.mindTraits,
          "Engineering",
          creature.getSubtrait('engineering'),
          "Memory",
          creature.getSubtrait('memory'),
        ),
        _buildTraitGroup(
          "WILL",
          creature.getSubtrait('resolve') + creature.getSubtrait('awareness'),
          AppColors.mindTraits,
          "Resolve",
          creature.getSubtrait('resolve'),
          "Awareness",
          creature.getSubtrait('awareness'),
        ),
        _buildTraitGroup(
          "DISPLAY",
          creature.getSubtrait('portrayal') + creature.getSubtrait('stunt'),
          AppColors.soulTraits,
          "Portrayal",
          creature.getSubtrait('portrayal'),
          "Stunt",
          creature.getSubtrait('stunt'),
        ),
        _buildTraitGroup(
          "CHARM",
          creature.getSubtrait('appeal') + creature.getSubtrait('language'),
          AppColors.soulTraits,
          "Appeal",
          creature.getSubtrait('appeal'),
          "Language",
          creature.getSubtrait('language'),
        ),
      ],
    );
  }

  int _calculateXP(Creature creature) {
    int xp = creature.finalDr * 100;
    int itemsCost = 0;
    for (var itemId in creature.items) {
      final item = itemsData.where((i) => i.id == itemId).firstOrNull;
      if (item != null) {
        itemsCost += item.cost;
      }
    }
    return xp - itemsCost;
  }

  String _formatModifier(int value) {
    final mod = value - 4;
    return mod >= 0 ? '+$mod' : '$mod';
  }

  Widget _buildTraitGroup(
    String traitName,
    int traitValue,
    Color color,
    String sub1Name,
    int sub1Value,
    String sub2Name,
    int sub2Value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text(
                    traitName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$traitValue (${_formatModifier(traitValue)})',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 24,
              color: color.withValues(alpha: 0.3),
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$sub1Name: ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$sub1Value (${_formatModifier(sub1Value)})',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$sub2Name: ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        TextSpan(
                          text: '$sub2Value (${_formatModifier(sub2Value)})',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KitDisplay {
  final String name;
  final int stacks;
  const _KitDisplay({required this.name, required this.stacks});
}
