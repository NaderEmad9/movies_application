import 'package:flutter/material.dart';

class NoMoviesFound extends StatelessWidget {
  const NoMoviesFound({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/no-movies.png',
            height: height * 0.12,
            width: width * 0.2,
          ),
          Text(
            'No Movies found',
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
