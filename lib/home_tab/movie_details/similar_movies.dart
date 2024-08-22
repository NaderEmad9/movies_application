import 'package:flutter/material.dart';
import '../../ui/app_colors.dart';

class SimilarMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.darkGreyColor,
                      borderRadius: BorderRadius.circular(7)),
                  margin: EdgeInsets.only(
                      bottom: height * 0.035, top: height * 0.027),
                  height: height * 0.363,
                  width: width * 0.36,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/Image.png",
                            height: height * 0.25,
                            width: width * 0.36,
                            fit: BoxFit.fill,
                          ),
                          InkWell(
                            onTap: (){},
                            child: Image.asset(
                              "assets/images/bookmark.png",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
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
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Deadpool 2",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.whiteColor),
                            ),
                            SizedBox(
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
