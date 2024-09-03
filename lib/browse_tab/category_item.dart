import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/moviesbygenre_tab.dart';
import 'package:movies_application/model/GenresResponse.dart';
import 'package:movies_application/browse_tab/poster_map.dart';

class GenreArguments {
  final String genre;
  final int genreid;

  GenreArguments({required this.genre, required this.genreid});
}

class CategoryItem extends StatelessWidget {
  final Genres genres;
  const CategoryItem({super.key, required this.genres});
  @override
  Widget build(BuildContext context) {
    final posterpath =
        genreAssetsMap[genres.name] ?? 'assets/images/browseicon.png';
    String genre = genres.name ?? '';
    int genreid = genres.id ?? 0;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          MoviesbygenreTab.routeName,
          arguments: GenreArguments(genre: genre, genreid: genreid),
        );
      },
      child: Stack(
        children: [
          Center(
            child: Image.network(
              posterpath,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Text(
              genre,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
