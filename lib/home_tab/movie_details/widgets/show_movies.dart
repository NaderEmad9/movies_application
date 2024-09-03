import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../ui/app_colors.dart';

class ShowMovies extends StatelessWidget {
  final String? imageUrl;

  const ShowMovies({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl ??
                  "https://wallpapers.com/images/high/error-placeholder-image-ozordu8s6n3xhi9h-2.png",
              width: double.infinity,
              height: height * 0.25,
              fit: BoxFit.fill,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  color: AppColors.orangeColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: AppColors.redColor,
              ),
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
        ),
      ],
    );
  }
}
