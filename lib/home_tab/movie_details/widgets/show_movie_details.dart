import 'package:flutter/material.dart';
import 'package:movies_application/home_tab/movie_details/widgets/custom_container_genre_movie.dart';
import 'package:movies_application/model/genre_map.dart';
import 'package:movies_application/ui/app_colors.dart';
import 'package:movies_application/browse_tab/moviesbygenre_tab.dart';
import 'package:movies_application/browse_tab/category_item.dart';

class ShowMovieDetails extends StatelessWidget {
  final String? title;
  final String? releaseDate;
  final String? imageUrl;
  final List<String?> genreMovie;
  final String? overview;
  final String? voteAverage;

  const ShowMovieDetails({
    Key? key,
    this.title,
    this.releaseDate,
    this.imageUrl,
    required this.genreMovie,
    this.overview,
    this.voteAverage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16), // Increased space between items
          Row(
            children: [
              Expanded(
                child: Text(
                  'Release Date: $releaseDate',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 20,
                width: 1,
                color: AppColors.lightGreyColor,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      voteAverage ?? '0.0',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Increased space between items
          Center(
            child: Wrap(
              spacing: 10.0, // Increased space between genre boxes
              runSpacing: 10.0, // Increased space between genre boxes
              children: genreMovie.map((genre) {
                return CustomContainerGenreMovie(
                  genreMovie: genre,
                  onTap: () {
                    // Navigate to MoviesbygenreTab with the selected genre
                    Navigator.pushNamed(
                      context,
                      MoviesbygenreTab.routeName,
                      arguments: GenreArguments(
                        genre: genre ?? 'Unknown',
                        genreid: GenreMap.genreMap.keys.firstWhere(
                          (key) => GenreMap.genreMap[key] == genre,
                          orElse: () => 0,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16), // Increased space between items
          Text(
            overview ?? '',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
