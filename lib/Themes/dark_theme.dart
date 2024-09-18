import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme colorScheme = const ColorScheme.dark(
  primary: Color(0xFF005667),
  onPrimary: Color(0xFF181d31),
  onPrimaryContainer: Color.fromARGB(255, 206, 210, 222),
  primaryContainer: Color.fromARGB(255, 251, 251, 253),
  secondary: Color.fromARGB(255, 8, 40, 48),
  surface: Colors.black,
  onSurface: Colors.white,
  error: Colors.red,
  onError: Colors.white,
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

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(
      colorScheme.primary,
    ),
    foregroundColor: WidgetStateProperty.all<Color>(
      colorScheme.surface,
    ),
    shadowColor: WidgetStateProperty.all<Color>(
      colorScheme.primary,
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    shadowColor: WidgetStateProperty.all<Color>(
      colorScheme.primary,
    ),
    foregroundColor: WidgetStateProperty.all<Color>(
      colorScheme.primary,
    ),
    side: WidgetStateProperty.all<BorderSide>(
      BorderSide(
        color: colorScheme.primary,
      ),
    ),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
  ),
);

CheckboxThemeData checkboxTheme = CheckboxThemeData(
  side: BorderSide(
    color: colorScheme.primary,
  ),
  checkColor: WidgetStateProperty.all<Color>(
    colorScheme.surface,
  ),
);
ThemeData darkTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    displayColor: Colors.white,
    bodyColor: Colors.white,
  ),
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  checkboxTheme: checkboxTheme,
);
