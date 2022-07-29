import 'package:ansar_rental/app/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.primaryAccent,
        textTheme: GoogleFonts.quicksandTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
        colorScheme: Get.theme.colorScheme.copyWith(
          primary: AppColors.primaryAccent,
        ),
        useMaterial3: true,
      );

  //unimplemented as of now
  static ThemeData get darkTheme => ThemeData();
}
