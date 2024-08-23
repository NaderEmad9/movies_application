// ignore: library_prefixes
import 'package:fluent_ui/fluent_ui.dart' as Fluent;
import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/browse_tab.dart';
import 'package:movies_application/home_tab/home_tab.dart';
import 'package:movies_application/search_tab/search_tab.dart';
import 'package:movies_application/watch_list_tab/watch_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppScreen extends StatefulWidget {
  static const String routeName = "AppScreen";

  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var homeText = AppLocalizations.of(context)!.home;
    var searchText = AppLocalizations.of(context)!.search;
    var browseText = AppLocalizations.of(context)!.browse;
    var watchListText = AppLocalizations.of(context)!.watchlist;

    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height * 0.09,
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Fluent.FluentIcons.home),
              label: homeText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Fluent.FluentIcons.video_search),
              label: searchText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Fluent.FluentIcons.my_movies_t_v),
              label: browseText,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Fluent.FluentIcons.favorite_list),
              label: watchListText,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    BrowseTab(),
    const WatchListTab()
  ];
}
