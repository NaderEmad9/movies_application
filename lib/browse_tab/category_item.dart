import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_application/ui/app_colors.dart';
import '../model/Category.dart';
import 'package:google_fonts/google_fonts.dart';
class CategoryItem extends StatelessWidget {
  Category category;
  int index;
  CategoryItem({required this.category, required this.index});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Center(
        child: Image.asset('assets/images/3.0x/default@3x.png'),
      ),
        Center(child: Text(
      category.name,
    style: GoogleFonts.poppins(textStyle: TextStyle(
    color: AppColors.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w500),
    )
        ))]);
  }
}
