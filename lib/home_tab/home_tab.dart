import 'package:flutter/material.dart';
import 'package:movies_application/home_tab/content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../ui/app_colors.dart';

class HomeTab extends StatefulWidget {
  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  bool _isTopContainerBookmarked = false;
  Map<int, bool> _bookmarkedItems = {};

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
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.3,
                color: AppColors.darkGreyColor,
                child: const Center(
                  child: Icon(
                    Icons.play_circle_filled,
                    size: 64,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Positioned(
                top: height * 0.15,
                left: width * 0.05,
                child: Container(
                  width: width * 0.28,
                  height: height * 0.2,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/deadpool.png',
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Movie title name hyb2a hna",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * 0.005),
                Text(
                  "Date of release hna and the movie time",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.moviesDetailsColor.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Content(
            title: releases,
            itemCount: 5,
            isScrollable: true,
            initialBookmarks: _bookmarkedItems,
            onBookmarkChanged: _handleContentBookmarkChange,
          ),
          Content(
            title: recommended,
            itemCount: 5,
            isScrollable: true,
            initialBookmarks: _bookmarkedItems,
            onBookmarkChanged: _handleContentBookmarkChange,
          ),
        ],
      ),
    );
  }
}
