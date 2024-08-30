import 'package:flutter/material.dart';
import 'package:movies_application/ui/app_colors.dart';

class SearchInputField extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  const SearchInputField({
    required this.onChanged,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headlineLarge,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        fillColor: AppColors.darkGreyColor,
        filled: true,
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
