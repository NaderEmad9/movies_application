import 'package:flutter/material.dart';
import 'package:movies_application/home_tab/movie_details/movie_details_screen.dart';
// import 'package:movies_application/app_screen/home_screen.dart';
import 'package:movies_application/ui/app_theme_data.dart';

import 'app_screen/app_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.appTheme,
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: AppScreen.routeName,
      routes: {
        AppScreen.routeName: (context) => const AppScreen(),
        MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
      },
    );
  }
}
