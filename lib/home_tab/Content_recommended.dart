import 'package:flutter/material.dart';
import '../ui/app_colors.dart';
import 'movie_details/screen/movie_details_screen.dart';
import '../model/Movie.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/model/MovieDetailsResponse.dart';

class ContentRecommended extends StatefulWidget {
  final String title;
  final List<Movie> movies;
  final bool isScrollable;
  final Map<int, bool> initialBookmarks;
  final Function(int) onBookmarkChanged;

  ContentRecommended({
    required this.title,
    required this.movies,
    required this.isScrollable,
    required this.initialBookmarks,
    required this.onBookmarkChanged,
  });

  @override
  _ContentRecommendedState createState() => _ContentRecommendedState();
}

class _ContentRecommendedState extends State<ContentRecommended> {
  late Map<int, bool> _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = {
      for (var movie in widget.movies)
        int.parse(movie.id!):
            widget.initialBookmarks[int.parse(movie.id!)] ?? false
    };
  }

  void _handleBookmarkChange(int movieId) {
    setState(() {
      _isBookmarked[movieId] = !_isBookmarked[movieId]!;
      widget.onBookmarkChanged(movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                var movie = widget.movies[index];
                int movieId = int.parse(movie.id!);
                bool isBookmarked = _isBookmarked[movieId] ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () async {
                          try {
                            HttpResponse<MovieDetailsResponse> movieDetails =
                                await ApiManager.getDetailsMovieApi(movieId);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    movieDetails: movieDetails.data),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Failed to load movie details')),
                            );
                          }
                        },
                        child: Container(
                          width: width * 0.235,
                          height: height * 0.143,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            _handleBookmarkChange(movieId);
                          },
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: isBookmarked
                                ? AppColors.orangeColor
                                : AppColors.whiteColor,
                            size: 24, // Ensure consistent size
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.orangeColor, size: 18),
                                  const SizedBox(width: 3),
                                  Text(
                                    movie.voteAverage.toString(),
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Text(
                                movie.title ?? "Title not available",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                movie.releaseDate ?? "Date not available",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
