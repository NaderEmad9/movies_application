import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/category_item.dart';
import 'package:provider/provider.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/model/DiscoverResponse.dart';
import 'package:movies_application/provider/bookmark_provider.dart';
import 'package:movies_application/ui/app_colors.dart';
import 'movie_item.dart';

class MoviesbygenreTab extends StatefulWidget {
  static const String routeName = "movies_by_genre";
  const MoviesbygenreTab({super.key});

  @override
  State<MoviesbygenreTab> createState() => _MoviesbygenreTabState();
}

class _MoviesbygenreTabState extends State<MoviesbygenreTab> {
  late ScrollController controller;
  List<Discover> moviesList = [];
  bool isLoadingMore = false;
  int currentPage = 1;
  late GenreArguments args; // Declare args to be used in multiple methods

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as GenreArguments;
    _loadInitialMovies();
  }

  void _loadInitialMovies() {
    ApiManager.getDiscoverMovieApi(args.genreid, currentPage).then((response) {
      setState(() {
        moviesList = response.data.results ?? [];
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose(); // Ensure controller is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookmarkProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            args.genre,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0,
          backgroundColor: AppColors.blackColor.withOpacity(0.5),
          surfaceTintColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: ListView.builder(
          controller: controller,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.12,
            horizontal: MediaQuery.of(context).size.width * 0.06,
          ),
          itemCount: moviesList.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == moviesList.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return MovieItem(movies: moviesList[index]);
          },
        ),
      ),
    );
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 1 && !isLoadingMore) {
      _loadMoreMovies();
    }
  }

  void _loadMoreMovies() {
    setState(() {
      isLoadingMore = true;
      currentPage++;
    });

    ApiManager.getDiscoverMovieApi(args.genreid, currentPage).then((response) {
      setState(() {
        moviesList.addAll(response.data.results ?? []);
        isLoadingMore = false;
      });
    }).catchError((error) {
      setState(() {
        isLoadingMore = false;
      });
    });
  }
}
