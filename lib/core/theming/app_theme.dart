import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/styles_manager.dart';
import 'color_manager.dart';

ThemeData appTheme() {
  return ThemeData.light().copyWith(
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: TextTheme(
      bodyMedium: Styles.textStyle16w5.copyWith(color: Colors.black),
      headlineLarge: Styles.textStyle20w7.copyWith(color: Colors.black),
      headlineMedium: Styles.textStyle18w5.copyWith(color: Colors.black),
      headlineSmall: Styles.textStyle14w5.copyWith(color: Colors.black),
      bodyLarge: Styles.textStyle24w7.copyWith(color: Colors.black),
      labelSmall: Styles.textStyle12w5.copyWith(color: Colors.black),
      displayLarge: Styles.textStyle22w7.copyWith(color: Colors.black),
      displayMedium: Styles.textStyle20w7.copyWith(color: ColorManager.orangeColor),
    ),
  primaryColor: ColorManager.whiteColor,
  cardColor: ColorManager.orangeColor,
  scaffoldBackgroundColor: ColorManager.blackColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        showUnselectedLabels: true,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        backgroundColor: ColorManager.grey
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.whiteColor,
      iconTheme: IconThemeData(color: ColorManager.blackColor, size: 24),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    textTheme: TextTheme(
      bodyMedium: Styles.textStyle16w5.copyWith(color: ColorManager.whiteColor),
      headlineLarge: Styles.textStyle20w7.copyWith(color: ColorManager.whiteColor),
      headlineMedium: Styles.textStyle18w5.copyWith(color: ColorManager.whiteColor),
      headlineSmall: Styles.textStyle14w5.copyWith(color: ColorManager.whiteColor),
      bodyLarge: Styles.textStyle24w7.copyWith(color: ColorManager.whiteColor),
      labelSmall: Styles.textStyle12w5.copyWith(color: ColorManager.whiteColor),
      displayLarge: Styles.textStyle22w7.copyWith(color: ColorManager.whiteColor),
      displayMedium: Styles.textStyle20w7.copyWith(color: ColorManager.orangeColor),

    ),
    primaryColor: ColorManager.whiteColor,
    cardColor: ColorManager.orangeColor,
    scaffoldBackgroundColor: ColorManager.blackColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 24),
        showUnselectedLabels: true,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        backgroundColor: ColorManager.grey
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.blackColor,
      iconTheme: IconThemeData(color: ColorManager.whiteColor, size: 24),
    ),
  );
}
