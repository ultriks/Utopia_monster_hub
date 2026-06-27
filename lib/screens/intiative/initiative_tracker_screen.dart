import 'package:flutter/material.dart';
import '../../models/initiative_entry.dart';
import '../../utils/constants.dart';

class InitiativeTrackerScreen extends StatefulWidget {
  const InitiativeTrackerScreen({super.key});

  @override
  State<InitiativeTrackerScreen> createState() =>
      _InitiativeTrackerScreenState();
}

class _InitiativeTrackerScreenState extends State<InitiativeTrackerScreen> {
  List<InitiativeEntry> entries = [];
  int currentTurnIndex = 0;

  void _nextTurn() {
    setState(() {
      if (entries.isNotEmpty) {
        currentTurnIndex = (currentTurnIndex + 1) % entries.length;
      }
    });
  }

  void _sortInitiative() {
    setState(() {
      entries.sort((a, b) => b.initiativeScore.compareTo(a.initiativeScore));
      currentTurnIndex = 0;
    });
  }

  void _addManualEntry() {
    _showCombatantDialog();
  }

  void _editEntry(int index) {
    final entry = entries[index];
    _showCombatantDialog(existingEntry: entry, existingIndex: index);
  }

  void _removeEntry(int index) {
    setState(() {
      entries.removeAt(index);
      // Fix turn index if it's now out of bounds or was pointing at/after the removed entry
      if (entries.isEmpty) {
        currentTurnIndex = 0;
      } else if (currentTurnIndex >= entries.length) {
        currentTurnIndex = entries.length - 1;
      }
    });
  }

  void _showCombatantDialog({
    InitiativeEntry? existingEntry,
    int? existingIndex,
  }) {
    final nameController = TextEditingController(
      text: existingEntry?.name ?? '',
    );
    final initiativeController = TextEditingController(
      text: existingEntry != null
          ? existingEntry.initiativeScore.toString()
          : '',
    );
    final shpController = TextEditingController(
      text: existingEntry != null ? existingEntry.currentShp.toString() : '',
    );
    final dhpController = TextEditingController(
      text: existingEntry != null ? existingEntry.currentDhp.toString() : '',
    );
    final staminaController = TextEditingController(
      text: existingEntry != null
          ? existingEntry.currentStamina.toString()
          : '',
    );

    final bool isEditing = existingEntry != null;
    String? nameError;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(isEditing ? 'Edit Combatant' : 'Add Combatant'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        errorText: nameError,
                      ),
                      onChanged: (_) {
                        if (nameError != null) {
                          setDialogState(() => nameError = null);
                        }
                      },
                    ),
                    TextField(
                      controller: initiativeController,
                      decoration: const InputDecoration(
                        labelText: 'Initiative Score',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: shpController,
                      decoration: const InputDecoration(labelText: 'SHP'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: dhpController,
                      decoration: const InputDecoration(labelText: 'DHP'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: staminaController,
                      decoration: const InputDecoration(labelText: 'Stamina'),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              actions: [
                if (isEditing)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _removeEntry(existingIndex!);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                    child: const Text('Delete'),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    if (name.isEmpty) {
                      setDialogState(() => nameError = 'Name cannot be empty');
                      return;
                    }

                    final initiative =
                        int.tryParse(initiativeController.text) ?? 0;
                    final shp = int.tryParse(shpController.text) ?? 0;
                    final dhp = int.tryParse(dhpController.text) ?? 0;
                    final stamina = int.tryParse(staminaController.text) ?? 0;

                    if (isEditing) {
                      setState(() {
                        final entry = entries[existingIndex!];
                        entry.name = name;
                        entry.initiativeScore = initiative;
                        entry.currentShp = shp;
                        entry.currentDhp = dhp;
                        entry.currentStamina = stamina;
                      });
                    } else {
                      setState(() {
                        entries.add(
                          InitiativeEntry(
                            id: DateTime.now().millisecondsSinceEpoch
                                .toString(),
                            name: name,
                            initiativeScore: initiative,
                            currentShp: shp,
                            currentDhp: dhp,
                            currentStamina: stamina,
                          ),
                        );
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: Text(isEditing ? 'Save' : 'Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initiative Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _sortInitiative,
            tooltip: 'Sort by Initiative',
          ),
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              setState(() {
                entries.clear();
                currentTurnIndex = 0;
              });
            },
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: entries.isEmpty
          ? const Center(
              child: Text(
                'No combatants yet.\nTap "Add Combatant" to begin.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                final isActive = index == currentTurnIndex;

                return Dismissible(
                  key: ValueKey(entry.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: AppColors.error,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _removeEntry(index),
                  child: ListTile(
                    tileColor: isActive
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : null,
                    title: Text(
                      entry.name,
                      style: TextStyle(
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(
                      'SHP: ${entry.currentShp} | DHP: ${entry.currentDhp} | STAM: ${entry.currentStamina}',
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: AppColors.surface,
                      child: Text(entry.initiativeScore.toString()),
                    ),
                    onTap: () => _editEntry(index),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _addManualEntry,
              child: const Text('Add Combatant'),
            ),
            ElevatedButton(
              onPressed: _nextTurn,
              child: const Text('Next Turn'),
            ),
          ],
        ),
      ),
    );
  }
}
