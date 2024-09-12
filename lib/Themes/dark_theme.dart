import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme colorScheme = const ColorScheme.dark(
  primary: Color(0xFF005667),
  secondary: Colors.deepPurpleAccent,
  surface: Colors.black,
  onSurface: Colors.white,
  background: Colors.black,
  onBackground: Colors.white,
  error: Colors.red,
  onError: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
);

AppBarTheme appBarTheme = const AppBarTheme(
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    displayColor: Colors.white,
  ),
  appBarTheme: appBarTheme,
);
