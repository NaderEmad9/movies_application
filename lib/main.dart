import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import 'package:movies_application/provider/app_locale_provider.dart';
import 'package:movies_application/provider/favourite_movie_provider.dart';
import 'package:movies_application/ui/app_theme_data.dart';
import 'package:provider/provider.dart';

import 'app_screen/app_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLocaleProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteMovieProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<AppLocaleProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppThemeData.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppScreen.routeName,
      locale: Locale(localeProvider.languageCode),
      routes: {
        AppScreen.routeName: (context) => const AppScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
      },
    );
  }
}
