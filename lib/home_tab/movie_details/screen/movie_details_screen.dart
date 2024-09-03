import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/home_tab/movie_details/widgets/show_movie_details.dart';
import 'package:movies_application/home_tab/movie_details/widgets/show_movies.dart';
import 'package:movies_application/home_tab/movie_details/widgets/similar_movies.dart';
import 'package:movies_application/model/MovieDetailsResponse.dart';
import 'package:movies_application/model/genre_map.dart';
import 'package:provider/provider.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import '../../../ui/app_colors.dart';
import 'package:movies_application/browse_tab/movie_item.dart';
import 'package:movies_application/model/Movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = "movie_details_screen";
  final MovieDetailsResponse movieDetails;

  const MovieDetailsScreen({Key? key, required this.movieDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String imageUrlConstant = "https://image.tmdb.org/t/p/w500";

    List<int?> movieGenreIds =
        movieDetails.genres?.map((genre) => genre.id).toList() ?? [];
    List<String> genreNames =
        movieGenreIds.map((id) => GenreMap.genreMap[id] ?? 'Unknown').toList();

    String releaseDateFormattedYear = DateFormat('yyyy').format(
        DateTime.parse(movieDetails.releaseDate ?? DateTime.now().toString()));

    String imageUrl = movieDetails.backdropPath != null
        ? "$imageUrlConstant${movieDetails.backdropPath}"
        : "https://wallpapers.com/images/high/error-placeholder-image-ozordu8s6n3xhi9h-2.png";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navigationBarColor,
        title: Text(
          movieDetails.title ?? "Title not Available",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          BookmarkButton(movieDetailsList: movieDetails),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowMovies(imageUrl: imageUrl),
            ShowMovieDetails(
              title: movieDetails.title,
              releaseDate: releaseDateFormattedYear,
              imageUrl: imageUrl,
              genreMovie: genreNames,
              overview: movieDetails.overview,
              voteAverage: movieDetails.voteAverage.toString(),
            ),
            Container(
              height: height * 0.46,
              margin: EdgeInsets.only(top: 15, bottom: height * 0.07),
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
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: SimilarMovies(movieId: movieDetails.id!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookmarkButton extends StatefulWidget {
  final MovieDetailsResponse? movieDetailsList;

  const BookmarkButton({Key? key, required this.movieDetailsList})
      : super(key: key);

  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  late bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _checkIfBookmarked();
  }

  Future<void> _checkIfBookmarked() async {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final movie = Movie(
      id: widget.movieDetailsList?.id.toString() ?? '',
      title: widget.movieDetailsList?.title ?? '',
    );
    final bookmarked = await bookmarkProvider.isBookmarked(movie);
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  void onBookmark() async {
    final bookmarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    final movie = Movie(
      id: widget.movieDetailsList?.id.toString() ?? '',
      title: widget.movieDetailsList?.title ?? '',
    );

    setState(() {
      isBookmarked = !isBookmarked;
    });

    if (isBookmarked) {
      await bookmarkProvider.addBookmark(movie);
    } else {
      await bookmarkProvider.removeBookmark(movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? AppColors.orangeColor : AppColors.lightGreyColor,
      ),
      onPressed: onBookmark,
    );
  }
}
