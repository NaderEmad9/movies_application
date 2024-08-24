import 'package:flutter/material.dart';
import '../../../ui/app_colors.dart';

class ShowMovies extends StatelessWidget {
  const ShowMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/Image.png",
          fit: BoxFit.fill,
        ),
        IconButton(
          onPressed: () {
            // Add your onPressed action here
          },
          icon: const Icon(
            Icons.play_circle_filled,
            color: AppColors.whiteColor,
          ),
          iconSize: 65,
        ),
      ],
    );
  }
}
