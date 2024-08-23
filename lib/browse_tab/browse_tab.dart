import 'package:flutter/material.dart';
import 'package:movies_application/ui/app_colors.dart';
import 'package:movies_application/model/category.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'category_item.dart';

class BrowseTab extends StatelessWidget {
  final List<Category> categoryList = Category.getCategory();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var category = AppLocalizations.of(context)!.category;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          category,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
        backgroundColor: AppColors.blackColor.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.12,
                  horizontal: width * 0.06), // Adjust padding if needed
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 16, // Horizontal space between items
                mainAxisSpacing: 16, // Vertical space between items
                childAspectRatio:
                    1.5, // Aspect ratio of each item (width/height)
              ),
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return CategoryItem(
                    category: categoryList[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}
