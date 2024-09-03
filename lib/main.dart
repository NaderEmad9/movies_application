import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/moviesbygenre_tab.dart';
import 'package:movies_application/model/MovieDetailsResponse.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'package:movies_application/provider/app_locale_provider.dart';
import 'package:movies_application/ui/app_theme_data.dart';
import 'app_screen/app_screen.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/provider/genre_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GenreProvider.fetchGenres();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BookmarkProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppLocaleProvider(),
        ),
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
      onGenerateRoute: (settings) {
        if (settings.name == MovieDetailsScreen.routeName) {
          final args = settings.arguments as MovieDetailsResponse;
          return MaterialPageRoute(
            builder: (context) {
              return MovieDetailsScreen(movieDetails: args);
            },
          );
        }
        // Add other routes here if needed
        return null;
      },
      routes: {
        AppScreen.routeName: (context) => const AppScreen(),
        MoviesbygenreTab.routeName: (context) => const MoviesbygenreTab(),
      },
    );
  }
}
