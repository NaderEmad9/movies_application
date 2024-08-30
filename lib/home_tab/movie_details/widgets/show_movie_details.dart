import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/home_tab/movie_details/widgets/custom_container_genre_movie.dart';
import 'package:movies_application/model/favourite_movie.dart';
import 'package:movies_application/provider/favourite_movie_provider.dart';
import 'package:provider/provider.dart';

import '../../../ui/app_colors.dart';

class ShowMovieDetails extends StatefulWidget {
  String? title;
  String? releaseDate;
  String? imageUrl;
  List<String?> genreMovie;
  String? overview;
  String? voteAverage;

  ShowMovieDetails(
      {required this.title,
      required this.releaseDate,
      required this.imageUrl,
      required this.genreMovie,
      required this.overview,
      required this.voteAverage});

  @override
  State<ShowMovieDetails> createState() => _ShowMovieDetailsState();
}

class _ShowMovieDetailsState extends State<ShowMovieDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    FavouriteMovie favouriteMovie = FavouriteMovie(
        imageUrl: widget.imageUrl,
        title: widget.title ?? "Unknown Title",
        releaseDate: widget.releaseDate ?? "Unknown Date");

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 12, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? "title not Available",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            widget.releaseDate ?? "Unknown Date",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.moviesDetailsColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: widget.imageUrl ??
                              "https://wallpapers.com/images/high/error-placeholder-image-ozordu8s6n3xhi9h-2.png",
                          width: width * 0.32,
                          height: height * 0.28,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.orangeColor,
                          )),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: AppColors.redColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -12.5,
                        left: -14,
                        child: Consumer<FavouriteMovieProvider>(
                          builder: (context, favouriteMovieProvider, child) {
                            bool isFavourite = favouriteMovieProvider
                                .isFavourite(favouriteMovie);
                            return IconButton(
                              onPressed: () {
                                if (isFavourite) {
                                  favouriteMovieProvider
                                      .removeFavourite(favouriteMovie);
                                  // print("remove: ${favouriteMovie.title}");
                                } else {
                                  favouriteMovieProvider
                                      .addFavourite(favouriteMovie);
                                  // print("add: ${favouriteMovie.title}");
                                }
                              },
                              icon: Icon(
                                isFavourite
                                    ? Icons.bookmark_added
                                    : Icons.bookmark_add_outlined,
                                color: isFavourite
                                    ? AppColors.orangeColor
                                    : AppColors.whiteColor,
                                size: 40,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: width * 0.55,
                margin: EdgeInsets.only(left: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: widget.genreMovie
                          .map((genre) =>
                              CustomContainerGenreMovie(genreMovie: genre))
                          .toList(),
                      // [
                      //   CustomContainerGenreMovie(),
                      //   CustomContainerGenreMovie(),
                      //   CustomContainerGenreMovie(),
                      //   CustomContainerGenreMovie(),
                      // ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(widget.overview ?? "Overview not Available",
                        maxLines: 5,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.lightGreyColor)),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.orangeColor,
                          size: 35,
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Text(
                          widget.voteAverage ?? "VoteAverage not Available",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
