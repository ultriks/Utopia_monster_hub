import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../models/creature.dart';
import '../../models/creature_body.dart';
import '../../models/creature_class.dart';
import '../../models/action.dart';
import '../../data/creature_bodies.dart';
import '../../data/kits_data.dart';
import '../../data/classes_data.dart';
import '../../data/database_helper.dart';
import '../../utils/constants.dart';

class QuickbuilderScreen extends StatefulWidget {
  const QuickbuilderScreen({super.key});

  @override
  State<QuickbuilderScreen> createState() => _QuickbuilderScreenState();
}

class _QuickbuilderScreenState extends State<QuickbuilderScreen> {
  int _currentStep = 0;

  // Builder state
  CreatureBody? _selectedBody;

  // Map of kitId -> stacks
  final Map<String, int> _selectedKits = {};

  // Selected classes
  CreatureClass? _selectedMartial;
  CreatureClass? _selectedArcane;
  CreatureClass? _selectedSupport;
  final List<CreatureClass> _selectedInnate = [];

  String _creatureName = 'New Monster';
  String _creatureDescription = '';

  // Distribute stats state
  final Map<String, int> _distributedBms = {'shp': 0, 'dhp': 0, 'stamina': 0};
  final Map<String, int> _distributedDefenses = {'physical': 0, 'energy': 0, 'heat': 0, 'chill': 0, 'psyche': 0};
  final Map<String, int> _distributedSubtraits = {'speed': 0, 'dexterity': 0, 'power': 0, 'fortitude': 0, 'engineering': 0, 'memory': 0, 'resolve': 0, 'awareness': 0, 'portrayal': 0, 'stunt': 0, 'appeal': 0, 'language': 0};
  final Map<String, int> _distributedRatings = {'block': 0, 'dodge': 0};
  final Map<String, int> _distributedTravel = {'land': 0, 'water': 0, 'air': 0};

  // ---------- Computed Stats ----------

  List<CreatureClass> get _allSelectedClasses {
    return [
      _selectedMartial,
      _selectedArcane,
      _selectedSupport,
      ..._selectedInnate,
    ].whereType<CreatureClass>().toList();
  }

  int get _bmsChoiceTotal {
    int choice = 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) choice += (kit.bmsStatsBonus['choice'] ?? 0) * stacks;
    });
    for (var cls in _allSelectedClasses) choice += cls.bmsStatsBonus['choice'] ?? 0;
    return choice;
  }
  int get _bmsChoiceUsed => _distributedBms.values.fold(0, (sum, val) => sum + val);

  int get _defensesChoiceTotal {
    int choice = 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) choice += (kit.defenseBonus['choice'] ?? 0) * stacks;
    });
    for (var cls in _allSelectedClasses) choice += cls.defenseBonus['choice'] ?? 0;
    return choice;
  }
  int get _defensesChoiceUsed => _distributedDefenses.values.fold(0, (sum, val) => sum + val);

  int get _subtraitsChoiceTotal {
    int choice = 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) choice += (kit.subtraitBonus['choice'] ?? 0) * stacks;
    });
    for (var cls in _allSelectedClasses) choice += cls.subtraitBonus['choice'] ?? 0;
    return choice;
  }
  int get _subtraitsChoiceUsed => _distributedSubtraits.values.fold(0, (sum, val) => sum + val);

  int get _ratingsChoiceTotal {
    int choice = 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) choice += (kit.ratingsBonus['choice'] ?? 0) * stacks;
    });
    for (var cls in _allSelectedClasses) choice += cls.ratingsBonus['choice'] ?? 0;
    return choice;
  }
  int get _ratingsChoiceUsed => _distributedRatings.values.fold(0, (sum, val) => sum + val);

  int get _travelChoiceTotal {
    int choice = 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) choice += (kit.travelBonus['choice'] ?? 0) * stacks;
    });
    for (var cls in _allSelectedClasses) choice += cls.travelBonus['choice'] ?? 0;
    return choice;
  }
  int get _travelChoiceUsed => _distributedTravel.values.fold(0, (sum, val) => sum + val);

  bool get _allChoicesDistributed {
    return _bmsChoiceUsed == _bmsChoiceTotal &&
           _defensesChoiceUsed == _defensesChoiceTotal &&
           _subtraitsChoiceUsed == _subtraitsChoiceTotal &&
           _ratingsChoiceUsed == _ratingsChoiceTotal &&
           _travelChoiceUsed == _travelChoiceTotal;
  }

  int get finalDr {
    int dr = _selectedBody?.baseDr ?? 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) {
        dr += kit.drBonus * stacks;
      }
    });
    for (var cls in _allSelectedClasses) {
      dr += cls.drBonus;
    }
    return dr;
  }

  int get finalShp {
    int shp = _selectedBody?.shp ?? 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) {
        shp += (kit.bmsStatsBonus['shp'] ?? 0) * stacks;
      }
    });
    for (var cls in _allSelectedClasses) {
      shp += cls.bmsStatsBonus['shp'] ?? 0;
    }
    return shp + (_distributedBms['shp'] ?? 0);
  }

  int get finalDhp {
    int dhp = _selectedBody?.dhp ?? 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) {
        dhp += (kit.bmsStatsBonus['dhp'] ?? 0) * stacks;
      }
    });
    for (var cls in _allSelectedClasses) {
      dhp += cls.bmsStatsBonus['dhp'] ?? 0;
    }
    return dhp + (_distributedBms['dhp'] ?? 0);
  }

  int get finalStamina {
    int stamina = _selectedBody?.stamina ?? 0;
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) {
        stamina += (kit.bmsStatsBonus['stamina'] ?? 0) * stacks;
      }
    });
    for (var cls in _allSelectedClasses) {
      stamina += cls.bmsStatsBonus['stamina'] ?? 0;
    }
    return stamina + (_distributedBms['stamina'] ?? 0);
  }

  List<CreatureAction> get _allActions {
    final List<CreatureAction> actions = [];
    for (var cls in _allSelectedClasses) {
      actions.addAll(cls.actions);
    }
    return actions;
  }

  List<String> get _allPassives {
    final List<String> passives = [];
    for (var cls in _allSelectedClasses) {
      passives.addAll(cls.passives);
    }
    _selectedKits.forEach((kitId, stacks) {
      final kit = kitsData.where((k) => k.id == kitId).firstOrNull;
      if (kit != null) {
        for (var passive in kit.passives) {
          passives.add(stacks > 1 ? '$passive (×$stacks)' : passive);
        }
      }
    });
    return passives;
  }

  // ---------- Save ----------

  void _saveCreature() async {
    if (_selectedBody == null) return;

    List<Map<String, dynamic>> kitsToSave = _selectedKits.entries
        .map((e) => {"kitId": e.key, "stacks": e.value})
        .toList();

    List<String> classesToSave = _allSelectedClasses.map((c) => c.id).toList();

    final customStats = <String, int>{};
    _distributedBms.forEach((key, val) { if(val > 0) customStats[key] = val; });
    _distributedDefenses.forEach((key, val) { if(val > 0) customStats['${key}Defense'] = val; });
    _distributedSubtraits.forEach((key, val) { if(val > 0) customStats[key] = val; });
    _distributedRatings.forEach((key, val) { if(val > 0) customStats['${key}Rating'] = val; });
    _distributedTravel.forEach((key, val) { if(val > 0) customStats['${key}Travel'] = val; });

    final newCreature = Creature(
      id: const Uuid().v4(),
      name: _creatureName,
      description: _creatureDescription,
      bodyType: _selectedBody!.type,
      shp: finalShp,
      dhp: finalDhp,
      stamina: finalStamina,
      finalDr: finalDr,
      kits: kitsToSave,
      classes: classesToSave,
      customStats: customStats,
      actions: _allActions,
      passives: _allPassives,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    try {
      await DatabaseHelper.instance.createCreature(newCreature);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving creature: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quickbuilder')),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && _selectedBody == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a body type')));
            return;
          }
          if (_currentStep == 3 && !_allChoicesDistributed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please distribute all available points first')));
            return;
          }
          if (_currentStep < 5) {
            setState(() => _currentStep += 1);
          } else {
            _saveCreature();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          } else {
            Navigator.pop(context);
          }
        },
        steps: [
          // Step 1: Body
          Step(
            title: const Text('Choose Body'),
            content: Column(
              children: creatureBodies.map((body) {
                return RadioListTile<CreatureBody>(
                  title: Text(body.name),
                  subtitle: Text('DR: ${body.baseDr} | SHP: ${body.shp} | DHP: ${body.dhp} | STA: ${body.stamina}'),
                  value: body,
                  // ignore: deprecated_member_use
                  groupValue: _selectedBody,
                  // ignore: deprecated_member_use
                  onChanged: (val) => setState(() => _selectedBody = val),
                );
              }).toList(),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
          ),

          // Step 2: Kits
          Step(
            title: const Text('Add Kits'),
            content: Column(
              children: kitsData.map((kit) {
                int count = _selectedKits[kit.id] ?? 0;
                return ListTile(
                  title: Text(kit.name),
                  subtitle: Text('+${kit.drBonus} DR, +${kit.bmsStatsBonus['shp'] ?? 0} SHP, +${kit.bmsStatsBonus['dhp'] ?? 0} DHP, +${kit.bmsStatsBonus['stamina'] ?? 0} STA'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: count > 0 ? () {
                          setState(() {
                            if (count == 1) {
                              _selectedKits.remove(kit.id);
                            } else {
                              _selectedKits[kit.id] = count - 1;
                            }
                          });
                        } : null,
                      ),
                      Text('$count'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _selectedKits[kit.id] = count + 1;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
          ),

          // Step 3: Classes
          Step(
            title: const Text('Add Classes'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<CreatureClass>(
                  decoration: const InputDecoration(labelText: 'Martial Class'),
                  // ignore: deprecated_member_use
                  value: _selectedMartial,
                  items: [
                    const DropdownMenuItem<CreatureClass>(value: null, child: Text('None')),
                    ...classesData.where((c) => c.category == CreatureClassCategory.martial).map((c) {
                      return DropdownMenuItem(value: c, child: Text('${c.name} (+${c.drBonus} DR)'));
                    })
                  ],
                  onChanged: (val) => setState(() => _selectedMartial = val),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<CreatureClass>(
                  decoration: const InputDecoration(labelText: 'Arcane Class'),
                  // ignore: deprecated_member_use
                  value: _selectedArcane,
                  items: [
                    const DropdownMenuItem<CreatureClass>(value: null, child: Text('None')),
                    ...classesData.where((c) => c.category == CreatureClassCategory.arcane).map((c) {
                      return DropdownMenuItem(value: c, child: Text('${c.name} (+${c.drBonus} DR)'));
                    })
                  ],
                  onChanged: (val) => setState(() => _selectedArcane = val),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<CreatureClass>(
                  decoration: const InputDecoration(labelText: 'Support Class'),
                  // ignore: deprecated_member_use
                  value: _selectedSupport,
                  items: [
                    const DropdownMenuItem<CreatureClass>(value: null, child: Text('None')),
                    ...classesData.where((c) => c.category == CreatureClassCategory.support).map((c) {
                      return DropdownMenuItem(value: c, child: Text('${c.name} (+${c.drBonus} DR)'));
                    })
                  ],
                  onChanged: (val) => setState(() => _selectedSupport = val),
                ),
                // Innate can be multiple, simple wrap of chips
                const SizedBox(height: 16),
                const Text('Innate Classes:'),
                Wrap(
                  spacing: 8,
                  children: classesData.where((c) => c.category == CreatureClassCategory.innate).map((c) {
                    final selected = _selectedInnate.contains(c);
                    return FilterChip(
                      label: Text('${c.name} (+${c.drBonus} DR)'),
                      selected: selected,
                      onSelected: (isSelected) {
                        setState(() {
                          if (isSelected) {
                            _selectedInnate.add(c);
                          } else {
                            _selectedInnate.remove(c);
                          }
                        });
                      },
                    );
                  }).toList(),
                )
              ],
            ),
            isActive: _currentStep >= 2,
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
          ),

          // Step 4: Distribute Stats
          Step(
            title: const Text('Distribute Stats'),
            content: _buildDistributeStatsStep(),
            isActive: _currentStep >= 3,
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
          ),

          // Step 5: Customize
          Step(
            title: const Text('Customize Identity'),
            content: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Creature Name'),
                  onChanged: (val) => _creatureName = val,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onChanged: (val) => _creatureDescription = val,
                ),
              ],
            ),
            isActive: _currentStep >= 4,
            state: _currentStep > 4 ? StepState.complete : StepState.indexed,
          ),

          // Step 6: Review
          Step(
            title: const Text('Review & Save'),
            content: _buildReviewStep(),
            isActive: _currentStep >= 5,
          ),
        ],
      ),
    );
  }

  // ---------- Distribute Stats Widget ----------

  Widget _buildDistributeStatsStep() {
    if (_bmsChoiceTotal == 0 && _defensesChoiceTotal == 0 && 
        _subtraitsChoiceTotal == 0 && _ratingsChoiceTotal == 0 && 
        _travelChoiceTotal == 0) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No stats to distribute from chosen kits/classes.'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_bmsChoiceTotal > 0) _buildStatDistributor('BMS Stats', _distributedBms, _bmsChoiceUsed, _bmsChoiceTotal),
        if (_defensesChoiceTotal > 0) _buildStatDistributor('Defenses', _distributedDefenses, _defensesChoiceUsed, _defensesChoiceTotal),
        if (_subtraitsChoiceTotal > 0) _buildStatDistributor('Subtraits', _distributedSubtraits, _subtraitsChoiceUsed, _subtraitsChoiceTotal),
        if (_ratingsChoiceTotal > 0) _buildStatDistributor('Ratings', _distributedRatings, _ratingsChoiceUsed, _ratingsChoiceTotal),
        if (_travelChoiceTotal > 0) _buildStatDistributor('Travel', _distributedTravel, _travelChoiceUsed, _travelChoiceTotal),
      ],
    );
  }

  Widget _buildStatDistributor(String title, Map<String, int> map, int used, int total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('$title ($used/$total distributed)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        ...map.keys.map((key) {
          int count = map[key] ?? 0;
          // remaining budget excluding this stat's current allocation
          int remaining = total - used + count;
          final controller = TextEditingController(text: '$count');
          // keep cursor at end
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(key.toUpperCase())),
                SizedBox(
                  width: 72,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      border: const OutlineInputBorder(),
                      errorText: count > remaining ? 'Over budget' : null,
                    ),
                    onChanged: (val) {
                      final parsed = int.tryParse(val);
                      if (parsed == null) return;
                      final clamped = parsed.clamp(0, remaining);
                      setState(() => map[key] = clamped);
                    },
                  ),
                ),
              ],
            ),
          );
        }),
        const Divider(),
      ],
    );
  }

  // ---------- Review Step Widget ----------

  Widget _buildReviewStep() {
    final selectedKitEntries = _selectedKits.entries.toList();
    final allClasses = _allSelectedClasses;
    final allActions = _allActions;
    final allPassives = _allPassives;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name & Description
        Text(
          _creatureName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        if (_creatureDescription.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(_creatureDescription, style: const TextStyle(color: Colors.grey)),
        ],
        const Divider(height: 24),

        // Body
        if (_selectedBody != null)
          Text("Body: ${_selectedBody!.name}", style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 16),

        // Stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _reviewStatBadge("DR", finalDr, AppColors.primary),
            _reviewStatBadge("SHP", finalShp, AppColors.heal),
            _reviewStatBadge("DHP", finalDhp, AppColors.error),
            _reviewStatBadge("STA", finalStamina, Colors.blue),
          ],
        ),

        // Kits
        if (selectedKitEntries.isNotEmpty) ...[
          const SizedBox(height: 20),
          _reviewSectionHeader('Kits'),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedKitEntries.map((entry) {
              final kit = kitsData.where((k) => k.id == entry.key).firstOrNull;
              final name = kit?.name ?? entry.key;
              return Chip(
                label: Text(entry.value > 1 ? '$name ×${entry.value}' : name),
                backgroundColor: AppColors.surface,
              );
            }).toList(),
          ),
        ],

        // Classes
        if (allClasses.isNotEmpty) ...[
          const SizedBox(height: 20),
          _reviewSectionHeader('Classes'),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allClasses.map((cls) {
              return Chip(
                label: Text('${cls.name} (${cls.category.name})'),
                backgroundColor: AppColors.surface,
              );
            }).toList(),
          ),
        ],

        // Actions
        if (allActions.isNotEmpty) ...[
          const SizedBox(height: 20),
          _reviewSectionHeader('Actions (${allActions.length})'),
          const SizedBox(height: 6),
          ...allActions.map((action) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.flash_on, size: 16, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(action.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(action.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ] else ...[
          const SizedBox(height: 20),
          const Text('No actions — add classes to gain abilities.', style: TextStyle(color: Colors.grey)),
        ],

        // Passives
        if (allPassives.isNotEmpty) ...[
          const SizedBox(height: 20),
          _reviewSectionHeader('Passives & Features (${allPassives.length})'),
          const SizedBox(height: 6),
          ...allPassives.map((passive) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(color: AppColors.primary, fontSize: 14)),
                Expanded(child: Text(passive, style: const TextStyle(fontSize: 13))),
              ],
            ),
          )),
        ],

        const SizedBox(height: 12),
      ],
    );
  }

  Widget _reviewStatBadge(String label, int value, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  Widget _reviewSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        letterSpacing: 1.0,
      ),
    );
  }
}
