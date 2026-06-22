import 'package:flutter/material.dart';
import '../models/creature.dart';
import '../data/database_helper.dart';
import '../utils/constants.dart';

class CreatureEditScreen extends StatefulWidget {
  final Creature creature;

  const CreatureEditScreen({super.key, required this.creature});

  @override
  State<CreatureEditScreen> createState() => _CreatureEditScreenState();
}

class _CreatureEditScreenState extends State<CreatureEditScreen> {
  late Creature _editCreature;

  final List<String> _subtraitNames = [
    'speed', 'dexterity', 'power', 'fortitude',
    'engineering', 'memory', 'resolve', 'awareness',
    'portrayal', 'stunt', 'appeal', 'language'
  ];

  final List<String> _defenseNames = [
    'physical', 'energy', 'heat', 'chill', 'psyche'
  ];

  @override
  void initState() {
    super.initState();
    // Deep copy the creature using toMap/fromMap to safely modify it
    _editCreature = Creature.fromMap(widget.creature.toMap());
    _editCreature.recalculateBaseStats();
  }

  int _getDiceCount(String rating) {
    if (rating.isEmpty) return 0;
    final parts = rating.split('d');
    if (parts.isNotEmpty) {
      return int.tryParse(parts[0]) ?? 0;
    }
    return 0;
  }

  bool get _isBmsValid {
    int initialSum = widget.creature.shp + widget.creature.dhp + widget.creature.stamina;
    int currentSum = _editCreature.shp + _editCreature.dhp + _editCreature.stamina;
    return initialSum == currentSum;
  }

  int get _bmsDelta {
    int initialSum = widget.creature.shp + widget.creature.dhp + widget.creature.stamina;
    int currentSum = _editCreature.shp + _editCreature.dhp + _editCreature.stamina;
    return initialSum - currentSum;
  }

  bool get _isSubtraitsValid {
    int initialSum = _subtraitNames.fold(0, (s, n) => s + widget.creature.getSubtrait(n));
    int currentSum = 0;
    for (var n in _subtraitNames) {
      int val = _editCreature.getSubtrait(n);
      if (val < 1) return false;
      currentSum += val;
    }
    return initialSum == currentSum;
  }

  int get _subtraitsDelta {
    int initialSum = _subtraitNames.fold(0, (s, n) => s + widget.creature.getSubtrait(n));
    int currentSum = _subtraitNames.fold(0, (s, n) => s + _editCreature.getSubtrait(n));
    return initialSum - currentSum;
  }

  bool get _isRatingsValid {
    int initialBlock = _getDiceCount(widget.creature.getRating('block'));
    int initialDodge = _getDiceCount(widget.creature.getRating('dodge'));
    int currentBlock = _getDiceCount(_editCreature.getRating('block'));
    int currentDodge = _getDiceCount(_editCreature.getRating('dodge'));

    return (currentBlock + currentDodge == initialBlock + initialDodge) &&
           currentBlock >= 1 && currentDodge >= 1;
  }

  int get _ratingsDelta {
    int initialSum = _getDiceCount(widget.creature.getRating('block')) + _getDiceCount(widget.creature.getRating('dodge'));
    int currentSum = _getDiceCount(_editCreature.getRating('block')) + _getDiceCount(_editCreature.getRating('dodge'));
    return initialSum - currentSum;
  }

  bool get _isDefensesValid {
    int initialSum = _defenseNames.fold(0, (s, n) => s + widget.creature.getDefense(n));
    int currentSum = _defenseNames.fold(0, (s, n) => s + _editCreature.getDefense(n));
    return initialSum == currentSum;
  }

  int get _defensesDelta {
    int initialSum = _defenseNames.fold(0, (s, n) => s + widget.creature.getDefense(n));
    int currentSum = _defenseNames.fold(0, (s, n) => s + _editCreature.getDefense(n));
    return initialSum - currentSum;
  }

  bool get _canSave => _isBmsValid && _isSubtraitsValid && _isRatingsValid && _isDefensesValid;

  void _save() async {
    if (!_canSave) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please balance all redistributed stats before saving.')),
      );
      return;
    }

    try {
      await DatabaseHelper.instance.updateCreature(_editCreature);
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving creature: $e')),
        );
      }
    }
  }

  void _updateStat(String key, int delta) {
    setState(() {
      _editCreature.customStats[key] = (_editCreature.customStats[key] ?? 0) + delta;
      _editCreature.recalculateBaseStats();
    });
  }

  Widget _buildSectionHeader(String title, int deltaPts, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          Row(
            children: [
              Text(
                'Pts remaining: $deltaPts',
                style: TextStyle(
                  color: deltaPts == 0 ? Colors.green : (deltaPts < 0 ? AppColors.error : Colors.orange),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                isValid ? Icons.check_circle : Icons.error,
                color: isValid ? Colors.green : AppColors.error,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String valueLabel, VoidCallback onDec, VoidCallback onInc, {bool isError = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: onDec,
                color: AppColors.primary,
              ),
              SizedBox(
                width: 50,
                child: Text(
                  valueLabel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isError ? AppColors.error : null,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: onInc,
                color: AppColors.primary,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redistribute Stats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BMS Section
            _buildSectionHeader('BMS Stats', _bmsDelta, _isBmsValid),
            _buildStatRow('SHP', _editCreature.shp.toString(), () => _updateStat('shp', -1), () => _updateStat('shp', 1)),
            _buildStatRow('DHP', _editCreature.dhp.toString(), () => _updateStat('dhp', -1), () => _updateStat('dhp', 1)),
            _buildStatRow('Stamina', _editCreature.stamina.toString(), () => _updateStat('stamina', -1), () => _updateStat('stamina', 1)),
            
            const Divider(height: 32),
            
            // Subtraits Section
            _buildSectionHeader('Subtraits', _subtraitsDelta, _isSubtraitsValid),
            ..._subtraitNames.map((name) {
              int val = _editCreature.getSubtrait(name);
              return _buildStatRow(
                name.substring(0, 1).toUpperCase() + name.substring(1),
                val.toString(),
                () => _updateStat(name, -1),
                () => _updateStat(name, 1),
                isError: val < 1,
              );
            }),

            const Divider(height: 32),

            // Ratings Section
            _buildSectionHeader('Ratings', _ratingsDelta, _isRatingsValid),
            _buildStatRow(
              'Block Rating',
              _editCreature.getRating('block'),
              () => _updateStat('blockRating', -1),
              () => _updateStat('blockRating', 1),
              isError: _getDiceCount(_editCreature.getRating('block')) < 1,
            ),
            _buildStatRow(
              'Dodge Rating',
              _editCreature.getRating('dodge'),
              () => _updateStat('dodgeRating', -1),
              () => _updateStat('dodgeRating', 1),
              isError: _getDiceCount(_editCreature.getRating('dodge')) < 1,
            ),

            const Divider(height: 32),

            // Defenses Section
            _buildSectionHeader('Defenses', _defensesDelta, _isDefensesValid),
            ..._defenseNames.map((name) {
              int val = _editCreature.getDefense(name);
              return _buildStatRow(
                name.substring(0, 1).toUpperCase() + name.substring(1),
                val.toString(),
                () => _updateStat('${name}Defense', -1),
                () => _updateStat('${name}Defense', 1),
              );
            }),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _canSave ? _save : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.black,
            ),
            child: const Text('Save Changes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
