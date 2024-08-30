// lib/home_tab/movie_item.dart
import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/category_item.dart';
import 'package:movies_application/browse_tab/genre_tags.dart';
import 'package:movies_application/browse_tab/moviesbygenre_tab.dart';
import 'package:provider/provider.dart';
import 'package:movies_application/model/Movie.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import 'package:movies_application/model/DiscoverResponse.dart';
import 'package:movies_application/provider/genre_provider.dart';
import 'package:movies_application/ui/app_colors.dart';

class MovieItem extends StatefulWidget {
  final Discover movies;
  const MovieItem({super.key, required this.movies});

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  late bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _checkIfBookmarked() async {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final movie = Movie.fromDiscover(widget.movies);
    final bookmarked = await bookmarkProvider.isBookmarked(movie);
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  void onBookmark() async {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final movie = Movie.fromDiscover(widget.movies);

    setState(() {
      isBookmarked = !isBookmarked;
    });

    if (isBookmarked) {
      await bookmarkProvider.addBookmark(movie);
    } else {
      await bookmarkProvider.removeBookmark(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(children: [
      Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.19,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MovieDetailsScreen.routeName,
                            arguments: widget.movies.id);
                      },
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${widget.movies.posterPath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MovieDetailsScreen.routeName,
                              arguments: widget.movies.id);
                        },
                        child: Text(
                          widget.movies.title ?? '',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked
                                ? AppColors.orangeColor
                                : AppColors.lightGreyColor,
                          ),
                          onPressed: onBookmark,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            '${widget.movies.voteAverage ?? 0.0}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.lightGreyColor),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        widget.movies.releaseDate ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.lightGreyColor),
                      ),
                      SizedBox(height: height * 0.01),
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: widget.movies.genreIds?.map((id) {
                              final genreName =
                                  GenreProvider.getGenreNameById(id);
                              return GenreTag(
                                id: id,
                                name: genreName,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MoviesbygenreTab.routeName,
                                      arguments: GenreArguments(
                                          genre: genreName, genreid: id));
                                },
                              );
                            }).toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      const Divider(
        thickness: 0.5,
        color: AppColors.lightGreyColor,
      ),
    ]);
  }
}
