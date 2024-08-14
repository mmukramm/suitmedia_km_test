import 'package:flutter/material.dart';
import 'package:suitmedia_km_test/styles/colors.dart';

ThemeData get lightTheme {
  return ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: true,
  ).copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: scaffoldColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )
      ),
    ),
  );
}

ColorScheme colorScheme = ColorScheme.fromSeed(
  primary: primaryColor,
  secondary: secondaryColor,
  onPrimary: scaffoldColor,
  onSecondary: scaffoldColor,
  seedColor: Colors.blueGrey,
);
