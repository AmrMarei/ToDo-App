import 'package:flutter/material.dart';

import 'app_color.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundLightColor,
      appBarTheme:
          AppBarTheme(backgroundColor: AppColors.primaryColor, elevation: 0),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.grayColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColors.backgroundLightColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: BorderSide(
                color: AppColors.whiteColor,
                width: 4,
              ))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.blackColor,
        ),
      ));

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.backgroundDarkColor,
      scaffoldBackgroundColor: AppColors.backgroundDarkColor,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.blackColor)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primaryColor,
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.grayColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: AppColors.blackDarkColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
              side: BorderSide(
                color: AppColors.blackDarkColor,
                width: 4,
              ))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        titleSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.whiteColor,
        ),
        bodySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
      ));
}
