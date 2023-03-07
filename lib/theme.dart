import 'package:flutter/material.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.pinkAccent,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 24, color: Colors.grey[900], fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 18, color: Colors.grey[850], fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 17, color: Colors.grey[850]),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.grey[850],
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.grey[800],
        ),
      ),
      iconTheme: IconThemeData(color: Colors.grey[850]));
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey[900],
      primaryColor: Colors.pinkAccent,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 24, color: Colors.grey[100], fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 20, color: Colors.grey[200], fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 18, color: Colors.grey[200]),
        bodyLarge: TextStyle(
          fontSize: 18,
          color: Colors.grey[100],
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: Colors.grey[200],
        ),
        bodySmall: TextStyle(
          fontSize: 14,
          color: Colors.grey[200],
        ),
      ),
      iconTheme: IconThemeData(color: Colors.grey[200]));
}
