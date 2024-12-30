// Importing necessary packages and files
import 'package:bloc_clean_coding/firebase_options.dart';
import 'package:bloc_clean_coding/repository/auth_api/auth_api_repository.dart';
import 'package:bloc_clean_coding/repository/auth_api/auth_http_api_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart'; // Package for dependency injection
import 'configs/routes/routes.dart'; // Custom routes
import 'configs/routes/routes_name.dart'; // Route names
import 'configs/themes/dark_theme.dart'; // Dark theme configuration
import 'configs/themes/light_theme.dart'; // Light theme configuration

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  servicesLocator(); // Initializing service locator for dependency injection
  runApp(const MyApp()); // Running the application
    FirebaseMessaging.onBackgroundMessage(_firebasemessahingBackground);
}

@pragma('vm:entry-point')
Future<void> _firebasemessahingBackground(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification?.title.toString());
  }
  if (kDebugMode) {
    print(message.notification?.body.toString());
  }
  if (kDebugMode) {
    print(message.data.toString());
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Constructor for MyApp widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light, // Setting theme mode to dark
      theme: lightTheme, // Setting light theme
      darkTheme: darkTheme, // Setting dark theme
      debugShowCheckedModeBanner: false,
       localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English locale
        Locale('es'), // Spanish locale
      ],
      initialRoute: RoutesName.signup, // Initial route
      onGenerateRoute: Routes.generateRoute, // Generating routes
    );
  }
}

// Function for initializing service locator
void servicesLocator() {
  getIt.registerLazySingleton<AuthApiRepository>(() =>
      AuthHttpApiRepository()); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository

}
