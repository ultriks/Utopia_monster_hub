import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'database_helper.dart';
import 'supabase_service.dart';

class SyncService {
  static final SyncService instance = SyncService._init();
  SyncService._init();

  /// Call this function when you want to sync pending items.
  /// Returns true if sync was completely successful or nothing to sync, false if there was a failure.
  Future<bool> syncPendingCreatures() async {
    // Guard: skip sync if Supabase was never initialized
    if (!SupabaseService.instance.isInitialized) {
      debugPrint("SyncService: Supabase not initialized — skipping sync.");
      return false;
    }

    final connectivityResultList = await (Connectivity().checkConnectivity());
    if (connectivityResultList.isEmpty || (connectivityResultList.length == 1 && connectivityResultList.first == ConnectivityResult.none)) {
      return false; // No internet connection
    }

    try {
      final db = await DatabaseHelper.instance.database;
      final pendingMaps = await db.query(
        'creatures',
        where: 'sync_status = ?',
        whereArgs: ['pending'],
      );

      if (pendingMaps.isEmpty) return true; // Nothing to sync

      final client = SupabaseService.instance.client;
      bool hasError = false;

      for (var map in pendingMaps) {
        var creatureMap = Map<String, dynamic>.from(map);
        // We do not want to upload the sync_status column to Supabase
        creatureMap.remove('sync_status');

        try {
          await client.from('creatures').upsert(creatureMap);

          // Update local DB to 'synced'
          await db.update(
            'creatures',
            {'sync_status': 'synced'},
            where: 'id = ?',
            whereArgs: [creatureMap['id']],
          );
        } catch (e) {
          debugPrint("Error syncing creature ${creatureMap['id']}: $e");
          hasError = true;
        }
      }

      return !hasError;
    } catch (e) {
      debugPrint("Error during sync process: $e");
      return false;
    }
  }
}
