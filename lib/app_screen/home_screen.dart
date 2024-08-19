import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as Fluent;
import 'package:movies_application/browse_tab/browse_tab.dart';
import 'package:movies_application/home_tab/home_tab.dart';
import 'package:movies_application/search_tab/search_tab.dart';
import 'package:movies_application/watch_list_tab/watch_list_tab.dart';

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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Fluent.FluentIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Fluent.FluentIcons.video_search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Fluent.FluentIcons.my_movies_t_v),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Fluent.FluentIcons.favorite_list),
              label: 'Watchlist',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> tabs = [HomeTab(), SearchTab(), BrowseTab(), WatchListTab()];
}
