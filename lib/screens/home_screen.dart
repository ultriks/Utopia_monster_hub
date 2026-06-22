import 'package:flutter/material.dart';
import '../models/creature.dart';
import '../data/database_helper.dart';
import '../data/sync_service.dart';
import '../widgets/creature_card.dart';
import 'quickbuilder/quickbuilder_screen.dart';

import 'initiative_tracker_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Creature> creatures = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCreatures();
    _attemptSync();
  }

  Future<void> _loadCreatures() async {
    final data = await DatabaseHelper.instance.readAllCreatures();
    setState(() {
      creatures = data;
      isLoading = false;
    });
  }

  Future<void> _attemptSync() async {
    bool success = await SyncService.instance.syncPendingCreatures();
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sync failed. Changes saved locally.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monster Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shield),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InitiativeTrackerScreen()),
              );
            },
            tooltip: 'Initiative Tracker',
          ),
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Syncing...')));
              _attemptSync().then((_) => _loadCreatures());
            },
          ),
        ],
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : creatures.isEmpty 
          ? const Center(child: Text("No monsters yet. Tap + to create one."))
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: creatures.length,
              itemBuilder: (context, index) {
                return CreatureCard(
                  creature: creatures[index],
                  onRefresh: _loadCreatures,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuickbuilderScreen()),
          ).then((_) => _loadCreatures());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
