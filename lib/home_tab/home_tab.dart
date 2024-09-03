import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/home_tab/Content_recommended.dart';
import 'package:movies_application/home_tab/content_newrealease.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import 'package:movies_application/model/MovieDetailsResponse.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:provider/provider.dart';
import '../model/PopularResponse.dart';
import '../ui/app_colors.dart';
import '../model/NewReleaseResponse.dart';
import '../model/TopRatedResponse.dart';
import '../model/Movie.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  Map<String, ValueNotifier<bool>> bookmarkNotifiers = {};

  @override
  void initState() {
    super.initState();
    // Initialize bookmark notifiers for existing movies
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    for (var movie in bookmarkProvider.bookmarkedMovies) {
      bookmarkNotifiers[movie.id!] = ValueNotifier(true);
    }
  }

  void _handleBookmarkChange(Movie movie) {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    if (bookmarkProvider.bookmarkedMovies.any((m) => m.id == movie.id)) {
      bookmarkProvider.removeBookmark(movie);
      bookmarkNotifiers[movie.id!]!.value = false;
    } else {
      bookmarkProvider.addBookmark(movie);
      bookmarkNotifiers[movie.id!]!.value = true;
    }
  }

  Map<int, bool> getInitialBookmarks(List<Movie> movies) {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    return {
      for (var movie in movies)
        int.parse(movie.id!):
            bookmarkProvider.bookmarkedMovies.any((m) => m.id == movie.id)
    };
  }

  List<Movie> convertToMovies(List<dynamic> items) {
    return items.map((item) {
      if (item is Popular || item is NewRelease || item is TopRated) {
        return Movie(
          id: item.id?.toString(),
          title: item.title,
          posterPath: item.posterPath,
          releaseDate: item.releaseDate,
          voteAverage: item.voteAverage,
        );
      } else {
        throw Exception('Unknown item type');
      }
    }).toList();
  }

  Widget _buildErrorWidget() {
    return Column(
      children: [
        const Text('Something went wrong'),
        ElevatedButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text('Try again'),
        ),
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.whiteColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var recommended = AppLocalizations.of(context)!.recommended;
    var releases = AppLocalizations.of(context)!.new_release;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: ListView(
        children: [
          FutureBuilder<HttpResponse<PopularResponse>>(
            future: ApiManager.getPopularMovies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingWidget();
              } else if (snapshot.hasError ||
                  snapshot.data?.statusCode != 200) {
                return _buildErrorWidget();
              } else if (snapshot.hasData &&
                  snapshot.data?.data.results != null &&
                  snapshot.data!.data.results!.isNotEmpty) {
                var movies = convertToMovies(snapshot.data!.data.results!);

                // Initialize bookmark notifiers
                for (var movie in movies) {
                  bookmarkNotifiers[movie.id!] = ValueNotifier(
                    Provider.of<BookmarkProvider>(context, listen: false)
                        .bookmarkedMovies
                        .any((m) => m.id == movie.id),
                  );
                }

                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index, realIndex) {
                        var movie = movies[index];
                        var imageUrl =
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}';

                        return Consumer<BookmarkProvider>(
                          builder: (context, bookmarkProvider, child) {
                            return InkWell(
                              onTap: () async {
                                try {
                                  int movieId = int.parse(
                                      movie.id!); // Convert String to int
                                  HttpResponse<MovieDetailsResponse>
                                      movieDetails =
                                      await ApiManager.getDetailsMovieApi(
                                          movieId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                          movieDetails: movieDetails.data),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Failed to load movie details')),
                                  );
                                }
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Text(
                                            'Image not available',
                                            style: TextStyle(
                                                color: AppColors.whiteColor),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    left: width * 0.05,
                                    bottom: -height * 0.1,
                                    child: Container(
                                      width: width * 0.32,
                                      height: height * 0.225,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGreyColor,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: Image.network(
                                                imageUrl,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Center(
                                                    child: Text(
                                                      'Image not available',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .whiteColor),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.blackColor
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(6),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child:
                                                  ValueListenableBuilder<bool>(
                                                valueListenable:
                                                    bookmarkNotifiers[
                                                        movie.id!]!,
                                                builder: (context, isBookmarked,
                                                    child) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _handleBookmarkChange(
                                                          movie);
                                                    },
                                                    child: Icon(
                                                      isBookmarked
                                                          ? Icons.bookmark
                                                          : Icons
                                                              .bookmark_outline,
                                                      color: isBookmarked
                                                          ? AppColors
                                                              .orangeColor
                                                          : AppColors
                                                              .whiteColor,
                                                      size: 24,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: width * 0.4,
                                    bottom: height * 0.05,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            movie.title ?? "Title",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          SizedBox(height: height * 0.005),
                                          Text(
                                            movie.releaseDate ?? "Date",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColors.orangeColor,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                movie.voteAverage.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      options: CarouselOptions(
                        height: height * 0.35,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                    ),
                    SizedBox(height: height * 0.015),

                    // FutureBuilder for new releases
                    FutureBuilder<HttpResponse<NewReleaseResponse>>(
                      future: ApiManager.getNewReleasesMoviesApi(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildLoadingWidget();
                        } else if (snapshot.hasError ||
                            snapshot.data?.statusCode != 200) {
                          return _buildErrorWidget();
                        } else if (snapshot.hasData &&
                            snapshot.data?.data.results != null &&
                            snapshot.data!.data.results!.isNotEmpty) {
                          var newReleases =
                              convertToMovies(snapshot.data!.data.results!);

                          // Initialize bookmark notifiers for new releases
                          for (var movie in newReleases) {
                            bookmarkNotifiers[movie.id!] = ValueNotifier(
                              Provider.of<BookmarkProvider>(context,
                                      listen: false)
                                  .bookmarkedMovies
                                  .any((m) => m.id == movie.id),
                            );
                          }

                          return ContentForNewRelease(
                            title: releases,
                            movies: newReleases,
                            isScrollable: true,
                            initialBookmarks: getInitialBookmarks(newReleases),
                            onBookmarkChanged: (movieId) {
                              var movie = newReleases.firstWhere(
                                  (m) => m.id == movieId.toString());
                              _handleBookmarkChange(movie);
                            },
                          );
                        } else {
                          return Column(
                            children: [
                              const Text('No data available'),
                              ElevatedButton(
                                onPressed: () {
                                  setState(
                                      () {}); // Rebuild to retry fetching data
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    // FutureBuilder for recommended content
                    FutureBuilder<HttpResponse<TopRatedResponse>>(
                      future: ApiManager.getTopRatedMoviesApi(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildLoadingWidget();
                        } else if (snapshot.hasError ||
                            snapshot.data?.statusCode != 200) {
                          return _buildErrorWidget();
                        } else if (snapshot.hasData &&
                            snapshot.data?.data.results != null &&
                            snapshot.data!.data.results!.isNotEmpty) {
                          var topRatedMovies =
                              convertToMovies(snapshot.data!.data.results!);

                          // Initialize bookmark notifiers for top rated movies
                          for (var movie in topRatedMovies) {
                            bookmarkNotifiers[movie.id!] = ValueNotifier(
                              Provider.of<BookmarkProvider>(context,
                                      listen: false)
                                  .bookmarkedMovies
                                  .any((m) => m.id == movie.id),
                            );
                          }

                          return ContentRecommended(
                            title: recommended,
                            movies: topRatedMovies,
                            isScrollable: true,
                            initialBookmarks:
                                getInitialBookmarks(topRatedMovies),
                            onBookmarkChanged: (movieId) {
                              var movie = topRatedMovies.firstWhere(
                                  (m) => m.id == movieId.toString());
                              _handleBookmarkChange(movie);
                            },
                          );
                        } else {
                          return Column(
                            children: [
                              const Text('No data available'),
                              ElevatedButton(
                                onPressed: () {
                                  setState(
                                      () {}); // Rebuild to retry fetching data
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const Text('No data available'),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {}); // Rebuild to retry fetching data
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
