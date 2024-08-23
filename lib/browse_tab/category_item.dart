import 'package:flutter/material.dart';
import '../model/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final int index;
  const CategoryItem({super.key, required this.category, required this.index});
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
