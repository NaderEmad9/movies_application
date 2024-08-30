import 'package:flutter/material.dart';
import 'package:movies_application/model/Movie.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:movies_application/search_tab/movie_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/ui/app_colors.dart';
import 'package:provider/provider.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (context, bookmarkProvider, child) {
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;
        var watchList = AppLocalizations.of(context)!.watchlist;
        List<Movie> bookmarkedMovies = bookmarkProvider.bookmarkedMovies;

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: AppColors.blackColor.withOpacity(0.5),
            surfaceTintColor: Colors.transparent,
            title: Text(
              watchList,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.left,
            ),
          ),
          extendBodyBehindAppBar: true,
          body: bookmarkedMovies.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/no-movies.png',
                        height: height * 0.12,
                        width: width * 0.2,
                      ),
                      Text(
                        'No Movies Added to watch list',
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : MovieList(searchResults: bookmarkedMovies),
        );
      },
    );
  }
}
