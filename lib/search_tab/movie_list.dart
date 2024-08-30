import 'package:flutter/material.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import 'package:movies_application/model/Movie.dart';
import 'package:movies_application/search_tab/movie_list_item.dart';

class MovieList extends StatelessWidget {
  final List<Movie> searchResults;

  const MovieList({
    required this.searchResults,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var movie = searchResults[index];
        var imageUrl = movie.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : 'https://via.placeholder.com/300x200/ffbb3b/333333?text=No+Image';

        return Consumer<BookmarkProvider>(
          builder: (context, bookmarkProvider, child) {
            return FutureBuilder<bool>(
              future: bookmarkProvider.isBookmarked(movie),
              builder: (context, snapshot) {
                bool isBookmarked = snapshot.data ?? false;

                return MovieListItem(
                  imageUrl: imageUrl,
                  title: movie.title ?? 'Unknown title',
                  description: movie.releaseDate ?? 'Unknown release date',
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MovieDetailsScreen.routeName,
                      arguments: {
                        'id': movie.id,
                      },
                    );
                  },
                  isBookmarked: isBookmarked,
                  onBookmarkToggle: () async {
                    if (isBookmarked) {
                      await bookmarkProvider.removeBookmark(movie);
                    } else {
                      await bookmarkProvider.addBookmark(movie);
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
