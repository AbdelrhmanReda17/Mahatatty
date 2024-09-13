import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// const Color customGrey = Color(0xFFb1b8ca); 

ColorScheme colorScheme = const ColorScheme.light(
  primary: Color(0xFF005667),
  onPrimary: Color(0xFF181d31),
  onPrimaryContainer: Color.fromARGB(255, 206, 210, 222),
  primaryContainer: Color.fromARGB(255, 251, 251, 253),
  secondary: Color.fromARGB(255, 8, 40, 48),
  surface: Colors.white,
  onSurface: Colors.black,
  background: Colors.white,
  onBackground: Colors.black,
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
  foregroundColor: Colors.black,
  scrolledUnderElevation: 0.0,
  elevation: 0.0,
);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      colorScheme.primary,
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      colorScheme.background,
    ),
    shadowColor: MaterialStateProperty.all<Color>(
      colorScheme.primary,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    ),
  ),
);

OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    shadowColor: MaterialStateProperty.all<Color>(
      colorScheme.primary,
    ),
    foregroundColor: MaterialStateProperty.all<Color>(
      colorScheme.primary,
    ),
    side: MaterialStateProperty.all<BorderSide>(
      BorderSide(
        color: colorScheme.primary,
      ),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
  checkColor: MaterialStateProperty.all<Color>(
    colorScheme.background,
  ),
);

ThemeData lightTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    displayColor: Colors.black,
    bodyColor: Colors.black,
  ),
  appBarTheme: lightAppBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  checkboxTheme: checkboxTheme,
);
