import 'package:flutter/material.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.green,
      foregroundColor: AppColors.white,
      textStyle: AppTextStyles.source.medium(fontSize: 13),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  appBarTheme: AppBarThemeData(backgroundColor: AppColors.white),
);
