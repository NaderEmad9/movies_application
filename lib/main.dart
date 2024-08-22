import 'package:flutter/material.dart';
import 'package:movies_application/ui/app_theme_data.dart';
import 'app_screen/app_screen.dart';
import 'package:movies_application/home_tab/movie_details/movie_details_screen.dart';
import 'package:movies_application/app_screen/app_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/ui/app_theme_data.dart';
import 'app_screen/app_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppThemeData.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppScreen.routeName,
      locale: Locale('ar'),
      routes: {
        AppScreen.routeName: (context) => const AppScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
      },
    );
  }
}
