import 'package:flutter/material.dart';
import 'package:movies_application/model/DiscoverResponse.dart';
import 'package:movies_application/provider/genre_provider.dart';
import 'package:movies_application/ui/app_colors.dart';

class MovieItem extends StatelessWidget {
  final Discover movies;
  const MovieItem({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(children: [
      Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.19,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movies.posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 10), // Space between image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies.title ?? '',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                          height: height *
                              0.01), // Space between title and release date
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 5),
                          Text(
                            '${movies.voteAverage ?? 0.0}', // Display the rating
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.lightGreyColor),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: height * 0.01), // Space before release date
                      Text(
                        movies.releaseDate ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.lightGreyColor),
                      ),
                      SizedBox(
                          height: height * 0.01), // Space before genre tags
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: movies.genreIds
                                ?.map((id) => GenreTag(
                                    id: id)) // Assuming you have a GenreTag widget or a way to map IDs to genre names
                                .toList() ??
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
        thickness: 0.5, // Ensure the thickness is reasonable
        color: AppColors.lightGreyColor,
      ),
    ]);
  }
}

class GenreTag extends StatelessWidget {
  final int id;
  const GenreTag({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    String genreName = GenreProvider.getGenreNameById(id);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGreyColor),
        color: AppColors.blackColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        genreName,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: AppColors.lightGreyColor),
      ),
    );
  }
}
