import 'package:flutter/material.dart';
import 'package:movies_application/browse_tab/category_item.dart';
import 'package:movies_application/ui/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies_application/model/GenresResponse.dart';
import 'package:movies_application/api/api_manager.dart';

class BrowseTab extends StatelessWidget {
  BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HttpResponse<GenresResponse>>(
      future: ApiManager.getGenreMovieApi(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data?.statusCode != 200) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Something went wrong'),
              TextButton(onPressed: () {}, child: const Text('Try again')),
            ],
          );
        } else {
          var genresList = snapshot.data?.data.genres ?? [];
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.category,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              elevation: 0,
              backgroundColor: AppColors.blackColor.withOpacity(0.5),
              surfaceTintColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
            body: GridView.builder(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.12,
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: genresList.length,
              itemBuilder: (context, index) {
                return CategoryItem(genres: genresList[index]);
              },
            ),
          );
        }
      },
    );
  }
}
