import 'package:ecom_app/util/color/custom_color.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: CustomColor.white,
  primaryColor: CustomColor.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: CustomColor.transparent,
    scrolledUnderElevation: 0,
  ),

  // Text Theme.
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    displayLarge: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: CustomColor.darkBlack,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    ),
  ),
);
