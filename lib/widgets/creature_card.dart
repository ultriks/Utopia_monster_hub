import 'package:flutter/material.dart';
import '../models/creature.dart';
import '../utils/constants.dart';
import '../screens/creature_detail_screen.dart';

class CreatureCard extends StatelessWidget {
  final Creature creature;
  final VoidCallback onRefresh;

  const CreatureCard({super.key, required this.creature, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatureDetailScreen(creature: creature)),
          );
          if (result == true) {
            onRefresh();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                creature.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text('Body: ${creature.bodyType.name}', style: const TextStyle(color: Colors.grey)),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DR ${creature.finalDr}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                      Text('${creature.shp} SHP', style: const TextStyle(color: AppColors.heal)),
                    ],
                  ),
                  Icon(Icons.monitor_heart, color: creature.syncStatus == 'pending' ? Colors.orange : Colors.green),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
