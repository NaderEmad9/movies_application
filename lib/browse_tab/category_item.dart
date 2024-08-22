import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/Category.dart';

class CategoryItem extends StatelessWidget {
  Category category;
  int index;
  CategoryItem({required this.category, required this.index});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset('assets/images/3.0x/default@3x.png'),
        ),
        Center(
            child: Text(
          category.name,
          style: Theme.of(context).textTheme.titleSmall,
        )),
      ],
    );
  }
}
