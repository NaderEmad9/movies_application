import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_application/api/api_manager.dart';
import 'package:movies_application/home_tab/Content_recommended.dart';
import 'package:movies_application/home_tab/content_newrealease.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/home_tab/movie_details/screen/movie_details_screen.dart';
import '../model/PopularResponse.dart';
import '../ui/app_colors.dart';
import '../model/NewReleaseResponse.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  bool _isTopContainerBookmarked = false;
  final Map<int, bool> _bookmarkedItems = {};

  void _handleTopContainerBookmarkChange() {
    setState(() {
      _isTopContainerBookmarked = !_isTopContainerBookmarked;
    });
  }

  void _handleContentBookmarkChange(int index) {
    setState(() {
      _bookmarkedItems[index] = !(_bookmarkedItems[index] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var recommended = AppLocalizations.of(context)!.recommended;
    var releases = AppLocalizations.of(context)!.new_release;

    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: ListView(
        children: [
        FutureBuilder<HttpResponse<PopularResponse>>(
        future: ApiManager.getPopularMovies(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(
    color: AppColors.whiteColor,
    ),
    );
    } else if (snapshot.hasError || snapshot.data?.statusCode != 200) {
    return Column(
    children: [
    const Text('Something went wrong'),
    ElevatedButton(
    onPressed: () {
    setState(() {});
    },
    child: const Text('Try again'),
    ),
    ],
    );
    } else if (snapshot.hasData &&
    snapshot.data?.data.results != null &&
    snapshot.data!.data.results!.isNotEmpty) {
    var movies = snapshot.data!.data.results!;

    return Column(
    children: [
    CarouselSlider.builder(
    itemCount: movies.length,
    itemBuilder: (context, index, realIndex) {
    var movie = movies[index];
    var imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';

    return InkWell(
    onTap: () {
    Navigator.pushNamed(context, MovieDetailsScreen.routeName);
    },
    child: Stack(
    clipBehavior: Clip.none,
    children: [
    // Background image
    Positioned.fill(
    child: Image.network(
    imageUrl,
    fit: BoxFit.fill,
    ),
    ),

    Center(
    child: Icon(
    Icons.play_circle_filled,
    size: 64,
    color: AppColors.whiteColor,
    ),
    ),

    Positioned(
    left: width * 0.05,
    bottom: -height * 0.1,
    child: Container(
    width: width * 0.32,
    height: height * 0.225,
    decoration: BoxDecoration(
    color: AppColors.lightGreyColor,
    borderRadius: BorderRadius.circular(6),
    ),
    child: Stack(
    children: [
    Center(
    child: InkWell(
    onTap: () {
    Navigator.pushNamed(context, MovieDetailsScreen.routeName);
    },
    child: Image.network(
    imageUrl,
    fit: BoxFit.fill,
    width: double.infinity,
    height: double.infinity,
    ),
    ),
    ),
    Align(
    alignment: Alignment.topLeft,
    child: IconButton(
    icon: _isTopContainerBookmarked
    ? const Icon(
    Icons.bookmark_added,
      color: AppColors.orangeColor,
    )
        : const Icon(
      Icons.bookmark_add_outlined,
      color: AppColors.whiteColor,
    ),
      onPressed: _handleTopContainerBookmarkChange,
    ),
    ),
    ],
    ),
    ),
    ),
      Positioned(
        left: width * 0.4,
        bottom: height * 0.05,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title ?? "Title not available",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: height * 0.005),
              Text(
                movie.releaseDate ?? "Date not available",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(
                  color: AppColors.moviesDetailsColor
                      .withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    ),
    );
    },
      options: CarouselOptions(
        height: height * 0.35,
        autoPlay: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
      ),
    ),
      SizedBox(height: height * 0.015),

      // FutureBuilder for new releases
      FutureBuilder<HttpResponse<NewReleaseResponse>>(
        future: ApiManager.getNewReleasesMoviesApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.whiteColor,
              ),
            );
          } else if (snapshot.hasError || snapshot.data?.statusCode != 200) {
            return Column(
              children: [
                const Text('Something went wrong'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text('Try again'),
                ),
              ],
            );
          } else if (snapshot.hasData &&
              snapshot.data?.data.results != null &&
              snapshot.data!.data.results!.isNotEmpty) {
            var newReleases = snapshot.data!.data.results!;

            return ContentForNewRelease(
              title: releases,
              movies: newReleases,
              isScrollable: true,
              initialBookmarks: _bookmarkedItems,
              onBookmarkChanged: _handleContentBookmarkChange,
            );
          } else {
            return Column(
              children: [
                const Text('No data available'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {}); // Rebuild to retry fetching data
                  },
                  child: const Text('Try again'),
                ),
              ],
            );
          }
        },
      ),

      ContentRecommended(
        title: recommended,
        itemCount: 5,
        isScrollable: true,
        initialBookmarks: _bookmarkedItems,
        onBookmarkChanged: _handleContentBookmarkChange,
      ),
    ],
    );
    } else {
      return Column(
        children: [
          const Text('No data available'),
          ElevatedButton(
            onPressed: () {
              setState(() {}); // Rebuild to retry fetching data
            },
            child: const Text('Try again'),
          ),
        ],
      );
    }
    },
        ),
        ],
        ),
    );
  }
}