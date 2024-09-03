import 'package:flutter/material.dart';
import '../../../ui/app_colors.dart';

class CustomContainerGenreMovie extends StatelessWidget {
  final String? genreMovie;
  final VoidCallback onTap;

  const CustomContainerGenreMovie({
    Key? key,
    required this.genreMovie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.5, color: AppColors.lightGreyColor),
        ),
        child: Text(
          genreMovie ?? "Unknown genre",
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.lightGreyColor),
        ),
      ),
    );
  }
}
