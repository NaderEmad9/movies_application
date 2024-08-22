import 'package:flutter/material.dart';
import '../../ui/app_colors.dart';

class ShowMovies extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
          icon: Icon(
            Icons.play_circle_filled,
            color: AppColors.whiteColor,
          ),
          iconSize: 65,
        ),
      ],
    );
  }

}