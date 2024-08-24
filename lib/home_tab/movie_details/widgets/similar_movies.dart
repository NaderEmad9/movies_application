import 'package:flutter/material.dart';
import '../../../ui/app_colors.dart';

class SimilarMovies extends StatefulWidget
{
  @override
  State<SimilarMovies> createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  List<bool> isBookmarked = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.moreLikeThisForGroundColor,
                      borderRadius: BorderRadius.circular(7)),
                  margin: EdgeInsets.only(
                      top: height * 0.027),
                  height: height * 0.34,
                  width: width * 0.31,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/Image.png",
                            height: height * 0.22,
                            width: width * 0.31,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: -14,
                            left: -15.5,
                            child: IconButton(
                              onPressed: () {
                                isBookmarked[index] = !isBookmarked[index];
                                setState(() {});
                              },
                              icon: isBookmarked[index]
                                  ? const Icon(
                                Icons.bookmark_added,
                                color: AppColors.orangeColor,
                                size: 25,
                              )
                                  : const Icon(
                                Icons.bookmark_add_outlined,
                                color: AppColors.whiteColor,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: AppColors.orangeColor,
                                  size: 25,
                                ),
                                SizedBox(
                                  width: width * 0.015,
                                ),
                                Text(
                                  "7.7",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Deadpool 2",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "2018  R  1h 59m",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                  color: AppColors.moviesDetailsColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
