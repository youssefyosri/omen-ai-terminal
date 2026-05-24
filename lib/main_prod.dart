import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'l10n/app_localizations.dart';
import 'core/env/app_config.dart';
import 'core/env/env_prod.dart';
import 'core/router/app_router.dart';
import 'core/storage/shared_prefs_provider.dart';
import 'core/firebase/firebase_options_prod.dart' as prod_options;
import 'core/theme/app_theme.dart';
import 'core/theme/locale_provider.dart';
import 'core/notifications/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env.prod");

  try {
    await Firebase.initializeApp(
      options: prod_options.DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (!e.toString().contains('duplicate-app')) {
      rethrow;
    }
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

  final prefs = await SharedPreferences.getInstance();

  final prodConfig = AppConfig(
    environment: Environment.prod,
    apiUrl: EnvProd.apiUrl,
    stripePublishableKey: EnvProd.stripePublishableKey,
  );

  Stripe.publishableKey = prodConfig.stripePublishableKey;
  await Stripe.instance.applySettings();

  final notificationService = PushNotificationService();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(prodConfig),
        sharedPrefsProvider.overrideWithValue(prefs),
      ],
      child: const OmenApp(),
    ),
  );
}

class OmenApp extends ConsumerWidget {
  const OmenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    final isDev = ref.watch(appConfigProvider).environment == Environment.dev;

    final currentLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Omen',
      debugShowCheckedModeBanner: isDev,

      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      themeMode: ThemeMode.dark,

      locale: currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      routerConfig: router,
    );
  }
}