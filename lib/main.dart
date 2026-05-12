import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vital_track/firebase_options.dart';
import 'package:vital_track/core/routers/app_router.dart';
import 'package:vital_track/core/theme/app_theme.dart';
import 'package:vital_track/l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:workmanager/workmanager.dart';
import 'presentation/auth/initialization_provider.dart';
import 'data/health_metrics/sync_health_use_case.dart';
import 'data/health_metrics/health_app_data_source.dart';
import 'data/health_metrics/health_repository_impl.dart';
import 'data/firebase_auth/auth_repository_impl.dart';
import 'data/health_metrics/shared_prefs_data_source.dart';

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

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "1",
    "healthSyncTask",
    frequency: const Duration(hours: 1),
    constraints: Constraints(networkType: NetworkType.connected),
  );
  
  runApp(
    const ProviderScope(
      child: VitalTrackApp(),
    ),
  );
}

class VitalTrackApp extends ConsumerWidget {
  const VitalTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    // Reset stop flag on app start as per context.md
    ref.listen(sharedPrefsDataSourceProvider, (previous, next) {
      if (next.hasValue) {
        next.value!.setSyncStopped(false);
      }
    });

    ref.listen(initializationProvider, (previous, next) {
      if (!next.isLoading) {
        FlutterNativeSplash.remove();
      }
    });

    return MaterialApp.router(
      title: 'VitalTrack',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
