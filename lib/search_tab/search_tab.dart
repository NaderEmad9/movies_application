import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/ui/app_colors.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  bool hasSearched = false;
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    var searching = AppLocalizations.of(context)!.searching;
    var noMovies = AppLocalizations.of(context)!.no_movies;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.08,
        title: TextFormField(
          style: Theme.of(context).textTheme.headlineLarge,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            fillColor: AppColors.darkGreyColor,
            filled: true,
            hintText: searching,
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
              hasSearched = value.isNotEmpty;
            });
          },
        ),
      ),
      body: hasSearched
          ? Container(
              // EL result hna

              )
          // and if nothing is found
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/no-movies.png',
                    height: height * 0.12,
                    width: width * 0.2,
                  ),
                  Text(
                    noMovies,
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
