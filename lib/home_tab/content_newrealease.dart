import 'package:flutter/material.dart';
import 'package:movies_application/model/NewReleaseResponse.dart';
import '../ui/app_colors.dart';
import 'movie_details/screen/movie_details_screen.dart';
import '../model/Movie.dart'; // تأكد من استيراد موديل الفيلم

class ContentForNewRelease extends StatefulWidget {
  final String title;
  final List<NewRelease> movies; // تغيير من Movie إلى NewRelease
  final bool isScrollable;
  final Map<int, bool> initialBookmarks;
  final void Function(int) onBookmarkChanged;

  const ContentForNewRelease({
    super.key,
    required this.title,
    required this.movies,
    this.isScrollable = false,
    required this.initialBookmarks,
    required this.onBookmarkChanged,
  });

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<ContentForNewRelease> {
  late Map<int, bool> _isBookmarked;

  @override
  void initState() {
    super.initState();
    _isBookmarked = Map.from(widget.initialBookmarks);
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
                bool isBookmarked = _isBookmarked[index] ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MovieDetailsScreen.routeName,
                            arguments: movie, // مرر الفيلم كـ arguments
                          );
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
                            setState(() {
                              _isBookmarked[index] = !isBookmarked;
                              widget.onBookmarkChanged(index);
                            });
                          },
                          child: isBookmarked
                              ? const Icon(
                            Icons.bookmark_added,
                            color: AppColors.orangeColor,
                          )
                              : const Icon(
                            Icons.bookmark_add_outlined,
                            color: AppColors.whiteColor,
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
                                    style: Theme.of(context).textTheme.labelLarge,
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