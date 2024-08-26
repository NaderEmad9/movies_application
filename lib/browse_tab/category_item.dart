import 'package:flutter/material.dart';
import 'package:movies_application/model/GenresResponse.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  Genres genres;
  CategoryItem({super.key, required this.genres});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/3.0x/default@3x.png'),
        ),
        Center(
            child: Text(
          genres.name ?? '',
          style: Theme.of(context).textTheme.titleSmall,
        )),
      ],
    );
  }
}
