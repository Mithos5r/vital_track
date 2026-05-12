import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import '../../firebase_options.dart';
import '../../domain/health_metrics/background_sync_service.dart';
import '../firebase_auth/auth_repository_impl.dart';
import 'health_app_data_source.dart';
import 'health_repository_impl.dart';
import 'shared_prefs_data_source.dart';
import 'sync_health_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workmanager_sync_service.g.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final container = ProviderContainer();
    try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      
      final authRepo = container.read(authRepositoryProvider);
      final user = authRepo.currentUser;
      
      if (user != null) {
        final prefs = await container.read(sharedPrefsDataSourceProvider.future);
        final syncUseCase = SyncHealthUseCase(
          repository: container.read(healthRepositoryProvider),
          healthDataSource: container.read(healthAppDataSourceProvider),
          prefsDataSource: prefs,
          userId: user.uid,
        );
        await syncUseCase.execute();
      }
      return true;
    } catch (e) {
      return false;
    } finally {
      container.dispose();
    }
  });
}

class WorkmanagerSyncService implements BackgroundSyncService {
  @override
  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
    await Workmanager().registerPeriodicTask(
      "1",
      "healthSyncTask",
      frequency: const Duration(hours: 1),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}

@riverpod
BackgroundSyncService backgroundSyncService(Ref ref) {
  return WorkmanagerSyncService();
}
