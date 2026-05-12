import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vital_track/firebase_options.dart';
import 'package:vital_track/core/routers/app_router.dart';
import 'package:vital_track/core/theme/app_theme.dart';
import 'package:vital_track/l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'presentation/auth/initialization_provider.dart';
import 'data/health_metrics/shared_prefs_data_source.dart';
import 'data/health_metrics/workmanager_sync_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final container = ProviderContainer();
    
    // Initialize background services without blocking app launch on minor failures
    await _initializeServices(container);

    runApp(
      UncontrolledProviderScope(
        container: container,
        child: const VitalTrackApp(),
      ),
    );
  } catch (e) {
    debugPrint('Fatal initialization error: $e');
    // Fallback to basic error view if everything fails
    runApp(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: Center(child: Text('Error initializing app'))),
        ),
      ),
    );
  }
}

Future<void> _initializeServices(ProviderContainer container) async {
  try {
    await container.read(backgroundSyncServiceProvider).initialize();
  } catch (e) {
    debugPrint('BackgroundSync initialization failed: $e');
  }
}

class VitalTrackApp extends ConsumerWidget {
  const VitalTrackApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    // Efficiently handle one-time startup actions
    _handleAppStartup(ref);

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

  void _handleAppStartup(WidgetRef ref) {
    // Reset stop flag on app start as per context.md
    ref.listen(sharedPrefsDataSourceProvider, (previous, next) {
      if (next.hasValue) {
        next.value!.setSyncStopped(false);
      }
    });

    // Handle splash removal
    ref.listen(initializationProvider, (previous, next) {
      if (!next.isLoading) {
        FlutterNativeSplash.remove();
      }
    });
  }
}
