import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_application/model/Movie.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import '../../../api/api_manager.dart';
import '../../../model/MoviesSimilarResponse.dart';
import '../../../ui/app_colors.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;

  const SimilarMovies({Key? key, required this.movieId}) : super(key: key);

  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<HttpResponse<MoviesSimilarResponse>>(
      future: ApiManager.getSimilarMoviesApi(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.orangeColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              const Text("Something went wrong"),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    ApiManager.getSimilarMoviesApi(widget.movieId);
                  });
                },
                child: const Text("Try Again"),
              ),
            ],
          );
        }

        if (snapshot.data?.statusCode != 200) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Something went wrong'),
              TextButton(
                onPressed: () {
                  setState(() {
                    ApiManager.getSimilarMoviesApi(widget.movieId);
                  });
                },
                child: const Text('Try Again'),
              ),
            ],
          );
        } else {
          var similarMoviesList = snapshot.data?.data.results ?? [];

          return SizedBox(
            height: height * 0.45, // Increased height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMoviesList.length,
              itemBuilder: (context, int index) {
                var similarMovie = similarMoviesList[index];

                String imageUrl = similarMovie.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500${similarMovie.backdropPath}"
                    : "https://wallpapers.com/images/high/error-placeholder-image-ozordu8s6n3xhi9h-2.png";

                String? releaseDate = similarMovie.releaseDate;
                String? releaseDateFormattedYear;

                if (releaseDate != null) {
                  try {
                    releaseDateFormattedYear =
                        DateFormat('yyyy').format(DateTime.parse(releaseDate));
                  } catch (e) {
                    print('Invalid date format: $e');
                  }
                }

                Movie favouriteMovie = Movie(
                  id: similarMovie.id.toString(),
                  posterPath: imageUrl,
                  title: similarMovie.title ?? "Unknown Title",
                  releaseDate: releaseDate ?? "Unknown Date",
                );

                return Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.moreLikeThisForGroundColor,
                          borderRadius:
                              BorderRadius.circular(10), // Added border radius
                        ),
                        margin: EdgeInsets.only(top: height * 0.027),
                        height: height * 0.35, // Increased height
                        width: width * 0.36,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ), // Added border radius only to the top corners
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    height: height * 0.22,
                                    width: width * 0.36,
                                    fit: BoxFit
                                        .cover, // Ensure the image covers the entire width
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orangeColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -12,
                                  left: -13.5,
                                  child: Consumer<BookmarkProvider>(
                                    builder:
                                        (context, bookmarkProvider, child) {
                                      return FutureBuilder<bool>(
                                        future: bookmarkProvider
                                            .isBookmarked(favouriteMovie),
                                        builder: (context, snapshot) {
                                          bool isBookmarked =
                                              snapshot.data ?? false;

                                          return IconButton(
                                            icon: Icon(
                                              isBookmarked
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: isBookmarked
                                                  ? AppColors.orangeColor
                                                  : AppColors.lightGreyColor,
                                              size: 30, // Increased icon size
                                            ),
                                            onPressed: () async {
                                              if (isBookmarked) {
                                                await bookmarkProvider
                                                    .removeBookmark(
                                                        favouriteMovie);
                                              } else {
                                                await bookmarkProvider
                                                    .addBookmark(
                                                        favouriteMovie);
                                              }
                                              setState(() {});
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: AppColors.orangeColor,
                                        size: 30, // Increased icon size
                                      ),
                                      SizedBox(width: width * 0.015),
                                      Text(
                                        similarMovie.voteAverage.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Colors
                                                    .white), // Increased text size
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    similarMovie.title ?? "Title not Available",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors
                                                .white), // Increased text size
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    releaseDateFormattedYear ??
                                        "Release unknown",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors
                                                .moviesDetailsColor), // Increased text size
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
