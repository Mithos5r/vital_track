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

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
    
    // Remove the native splash screen when initialization is finished
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
