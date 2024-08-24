import 'package:flutter/material.dart';
import '../../../ui/app_colors.dart';

class ShowMovieDetails extends StatefulWidget {
  @override
  State<ShowMovieDetails> createState() => _ShowMovieDetailsState();
}

class _ShowMovieDetailsState extends State<ShowMovieDetails> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(top: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dora and the lost city of gold",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "2019  PG-13  2h 7m",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.moviesDetailsColor),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/Image.png",
                          width: width * 0.32,
                          height: height * 0.3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: -12.5,
                        left: -14,
                        child: IconButton(
                            onPressed: () {
                              isBookmarked = !isBookmarked;
                              setState(() {});
                            },
                            icon: isBookmarked
                                ? const Icon(
                              Icons.bookmark_added,
                              color: AppColors.orangeColor,
                              size: 40,
                            )
                                : const Icon(
                              Icons.bookmark_add_outlined,
                              color: AppColors.whiteColor,
                              size: 40,
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: width *0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 28),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 0.5, color: AppColors.lightGreyColor)),
                      child: Text(
                        "Action",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.lightGreyColor),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Text(
                        "Having spent most of her life exploring the jungle, nothing could prepare Dora for her most dangerous adventure yet — high school. ",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: AppColors.lightGreyColor)),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.orangeColor,
                          size: 40,
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        Text(
                          "7.7",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
