import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_application/ui/app_colors.dart';

class AppThemeData {
  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColors.blackColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.blackColor),
    splashFactory: NoSplash.splashFactory,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.darkGreyColor))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: AppColors.lightGreyColor,
      selectedItemColor: AppColors.orangeColor,
      backgroundColor: AppColors.navigationBarColor,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.navigationBarColor,
      elevation: 0.5,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.whiteColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.whiteColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.whiteColor,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.whiteColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.whiteColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.lightGreyColor,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: AppColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.lightGreyColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.lightGreyColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.lightGreyColor),
      ),
      labelStyle: const TextStyle(color: AppColors.lightGreyColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.lightGreyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: AppColors.orangeColor,
        ),
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.lightGreyColor,
      ),
      floatingLabelStyle: const TextStyle(color: AppColors.whiteColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.lightGreyColor,
      selectionColor: AppColors.lightGreyColor.withOpacity(0.2),
      selectionHandleColor: AppColors.lightGreyColor.withOpacity(0.2),
    ),
  );
}
