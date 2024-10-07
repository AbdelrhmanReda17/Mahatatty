import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const Color customGrey = Color(0xFFb1b8ca); // Example grey color

// const Color customGrey = Color(0xFFb1b8ca);

ColorScheme colorScheme = const ColorScheme.light(
  primary: Color(0xFF005667),
  onPrimary: Color(0xFF181d31),
  onPrimaryContainer: Color.fromARGB(255, 206, 210, 222),
  primaryContainer: Color.fromARGB(255, 251, 251, 253),
  secondary: Color.fromARGB(255, 8, 40, 48),
  surface: Colors.white,
  onSurface: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  onSecondary: Colors.white,
);

AppBarTheme lightAppBarTheme = const AppBarTheme(
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
  backgroundColor: Colors.white,
  foregroundColor: Color(0xFF181d31),
  scrolledUnderElevation: 0.0,
  elevation: 0.0,
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
    elevation: WidgetStateProperty.all<double>(0.0),
    shadowColor: WidgetStateProperty.all<Color>(colorScheme.primary),
    foregroundColor: WidgetStateProperty.all<Color>(
      colorScheme.primary,
    ),
    backgroundColor: WidgetStateProperty.all<Color>(
      colorScheme.surface,
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

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: colorScheme.primaryContainer,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 15.0,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
      color: colorScheme.primary,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
      color: colorScheme.onPrimaryContainer,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
      color: colorScheme.error.withOpacity(0.5),
    ),
  ),
  floatingLabelBehavior: FloatingLabelBehavior.never,
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
      color: colorScheme.error,
    ),
  ),
  errorMaxLines: 2,
  hintStyle: TextStyle(
    color: colorScheme.onPrimaryContainer,
  ),
);

ThemeData lightTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    displayColor: const Color(0xFF181d31),
    bodyColor: const Color(0xFF181d31),
  ),
  appBarTheme: lightAppBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  checkboxTheme: checkboxTheme,
  inputDecorationTheme: inputDecorationTheme,
);

