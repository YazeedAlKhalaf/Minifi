import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:minifi_app/src/app/generated/locator/locator.dart';
import 'package:minifi_app/src/app/generated/router/router.gr.dart';
import 'package:minifi_app/src/ui/global/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Sets logging level
  Logger.level = Level.debug;

  // Register all the models and services before the app starts
  setupLocator();

  // Runs the app :)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minifi',
      initialRoute: Routes.startupView,
      onGenerateRoute: Router().onGenerateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: ThemeData.light().copyWith(
        primaryColor: primaryColor,
        accentColor: accentColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: accentColor,
        ),
      ),
    );
  }
}
