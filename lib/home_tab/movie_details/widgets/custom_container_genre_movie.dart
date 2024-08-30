import 'package:flutter/material.dart';

import '../../../ui/app_colors.dart';

class CustomContainerGenreMovie extends StatelessWidget {
  String? genreMovie;

  CustomContainerGenreMovie({required this.genreMovie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: AppColors.lightGreyColor)),
      child: Text(
        genreMovie ?? "unKnown genre",
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: AppColors.lightGreyColor),
      ),
    );
  }
}
