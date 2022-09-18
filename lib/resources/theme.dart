import 'package:flutter/material.dart';
import './app_colors.dart';

class AppTheme {
  static ThemeData get get {
    return ThemeData.light().copyWith(
      backgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(color: AppColors.appBarColor),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: ThemeData.light().textTheme.apply(
            fontFamily: 'Poppins',
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  static CustomTheme of(context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return LightTheme();
    } else {
      return LightTheme();
    }
  }
}

abstract class CustomTheme {
  TextStyle get headline1;
  TextStyle get subHeading1;
  TextStyle get label1;
  TextStyle get small1;
  TextStyle get small2;
}

class LightTheme extends CustomTheme {
  @override
  TextStyle get headline1 => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 21,
        height: 1.3,
        color: AppColors.backgroundColor,
      );

  @override
  TextStyle get label1 => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        height: 1.5,
        color: AppColors.accentColor,
      );

  @override
  TextStyle get small1 => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: AppColors.accentColor,
      );

  @override
  TextStyle get small2 => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        color: AppColors.accentColor,
      );

  @override
  TextStyle get subHeading1 => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColors.accentColor,
        height: 1.5,
      );
}
