import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../api/api_manager.dart';
import '../../../model/MoviesSimilarResponse.dart';
import '../../../model/favourite_movie.dart';
import '../../../provider/favourite_movie_provider.dart';
import '../../../ui/app_colors.dart';

class SimilarMovies extends StatefulWidget {
  String? imageUrl;
  String? voteAverage;
  String? title;
  String? releaseDate;
  String imageUrlConstant = "https://image.tmdb.org/t/p/w500";
  int movieId;

  SimilarMovies({
    this.imageUrl,
    this.voteAverage,
    this.title,
    this.releaseDate,
    required this.movieId,
  });

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
            // print("Error: ${snapshot.error}");
            return Column(
              children: [
                const Text("Something went wrong"),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getSimilarMoviesApi(widget.movieId);
                  },
                  child: const Text("Try Again"),
                ),
              ],
            );
          }
          //server => error ,success
          if (snapshot.data!.statusCode != 200) {
            // print("status_code: ${snapshot.data!.statusCode}");

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Something went wrong'),
                TextButton(
                    onPressed: () {
                      ApiManager.getSimilarMoviesApi(widget.movieId);
                    },
                    child: const Text('Try Again')),
              ],
            );
          } else {
            var similarMoviesList = snapshot.data?.data.results ?? [];

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: similarMoviesList.length,
                itemBuilder: (context, int index) {
                  var similarMovie = similarMoviesList[index];

                  String imageUrl = similarMovie.backdropPath != null
                      ? "${widget.imageUrlConstant}${similarMovie.backdropPath}"
                      : "https://wallpapers.com/images/high/error-placeholder-image-ozordu8s6n3xhi9h-2.png";

                  String? releaseDate = similarMovie.releaseDate;
                  String? releaseDateFormattedYear;

                  if (releaseDate != null) {
                    try {
                      releaseDateFormattedYear = DateFormat('yyyy')
                          .format(DateTime.parse(releaseDate));
                    } catch (e) {
                      print('Invalid date format: $e');
                    }
                  }

                  FavouriteMovie favouriteMovie = FavouriteMovie(
                    imageUrl: imageUrl,
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
                              borderRadius: BorderRadius.circular(7)),
                          margin: EdgeInsets.only(top: height * 0.027),
                          height: height * 0.36,
                          width: width * 0.36,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    height: height * 0.22,
                                    width: width * 0.35,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.orangeColor,
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                  Positioned(
                                    top: -12,
                                    left: -13.5,
                                    child: Consumer<FavouriteMovieProvider>(
                                      builder: (context, favouriteMovieProvider,
                                          child) {
                                        bool isFavourite =
                                            favouriteMovieProvider
                                                .isFavourite(favouriteMovie);
                                        return IconButton(
                                          onPressed: () {
                                            if (isFavourite) {
                                              favouriteMovieProvider
                                                  .removeFavourite(
                                                      favouriteMovie);
                                              // print(
                                              //     "remove: ${favouriteMovie.title}");
                                            } else {
                                              favouriteMovieProvider
                                                  .addFavourite(favouriteMovie);
                                              // print(
                                              //     "add: ${favouriteMovie.title}");
                                            }
                                          },
                                          icon: Icon(
                                            isFavourite
                                                ? Icons.bookmark_added
                                                : Icons.bookmark_add_outlined,
                                            color: isFavourite
                                                ? AppColors.orangeColor
                                                : AppColors.whiteColor,
                                            size: 32,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 9),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: AppColors.orangeColor,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: width * 0.015,
                                        ),
                                        Text(
                                          similarMovie.voteAverage.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      similarMovie.title ??
                                          "title not Available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.whiteColor),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      releaseDateFormattedYear ??
                                          "release unknown",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color:
                                                  AppColors.moviesDetailsColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          }
        });
  }
}
