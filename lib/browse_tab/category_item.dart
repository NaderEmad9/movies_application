import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/moviesbygenre_tab.dart';
import 'package:movies_application/model/GenresResponse.dart';

class GenreArguments {
  final String genre;
  final Object genreid;

  GenreArguments({required this.genre, required this.genreid});
}

class CategoryItem extends StatelessWidget {
  // Changed to StatelessWidget
  final Genres genres; // Made it final
  const CategoryItem({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    String genre = genres.name ?? '';
    Object genreid = genres.id ?? '';

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
            child: Image.asset('assets/images/3.0x/default@3x.png'),
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
