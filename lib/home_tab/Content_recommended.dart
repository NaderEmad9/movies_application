import 'package:flutter/material.dart';
import '../ui/app_colors.dart';
import 'movie_details/screen/movie_details_screen.dart';

class ContentRecommended extends StatefulWidget {
  final String title;
  final int itemCount;
  final bool isScrollable;
  final Map<int, bool> initialBookmarks;
  final void Function(int) onBookmarkChanged;

  const ContentRecommended({
    super.key,
    required this.title,
    required this.itemCount,
    this.isScrollable = false,
    required this.initialBookmarks,
    required this.onBookmarkChanged,
  });

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<ContentRecommended> {
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
              itemCount: widget.itemCount,
              itemBuilder: (context, index) {
                bool isBookmarked = _isBookmarked[index] ?? false;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MovieDetailsScreen.routeName);
                        },
                        child: Container(
                          width: width * 0.235,
                          height: height * 0.143,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/Dora.png',
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
                                    "10",
                                    style:
                                    Theme.of(context).textTheme.labelLarge,
                                  ),
                                ],
                              ),
                              Text(
                                "Movie title",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "date/time",
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