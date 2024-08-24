import 'package:flutter/material.dart';
import 'package:movies_application/home_tab/movie_details/widgets/show_movie_details.dart';
import 'package:movies_application/home_tab/movie_details/widgets/show_movies.dart';
import 'package:movies_application/home_tab/movie_details/widgets/similar_movies.dart';
import '../../../ui/app_colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movie_details_screen";

  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navigationBarColor,
        title: Text(
          "Dora and the lost city of gold",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShowMovies(),
            ShowMovieDetails(),
            Container(
              height: height*0.46,
              margin: EdgeInsets.only(top: 15, bottom: height*0.07),
              color: AppColors.moreLikeThisBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 22, top: 20),
                    child: Text(
                      "More Like This",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(child: SimilarMovies()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
