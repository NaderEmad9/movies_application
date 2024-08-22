import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_application/model/Category.dart';
import 'category_item.dart';

class BrowseTab extends StatelessWidget {
  final List<Category> categoryList = Category.getCategory();

  BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 70),
            child: Text(
              'Browse Category',
              style: GoogleFonts.inter(
                textStyle: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(left: 20, right: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10, // Horizontal space between items
              mainAxisSpacing: 10, // Vertical space between items
              childAspectRatio: 1.5, // Aspect ratio of each item (width/height)
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Callback function
                },
                child:
                    CategoryItem(category: categoryList[index], index: index),
              );
            },
            itemCount: categoryList.length,
          ),
        ),
      ],
    );
  }
}
