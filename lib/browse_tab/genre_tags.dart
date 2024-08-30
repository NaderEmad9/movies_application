import 'package:flutter/material.dart';
import 'package:movies_application/provider/genre_provider.dart';
import 'package:movies_application/ui/app_colors.dart';

class GenreTag extends StatelessWidget {
  final int id;
  final String name;
  final VoidCallback onTap;
  const GenreTag(
      {super.key, required this.id, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String genreName = GenreProvider.getGenreNameById(id);
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGreyColor),
            color: AppColors.blackColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            genreName,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.lightGreyColor),
          ),
        ));
  }
}
