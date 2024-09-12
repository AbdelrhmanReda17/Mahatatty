import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  outlineBorder: BorderSide(color: colorScheme.primary),
  border: OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(color: colorScheme.primary),
  ),
  // enabledBorder: OutlineInputBorder(
  //   borderRadius: const BorderRadius.all(
  //     Radius.circular(20.0),
  //   ),
  //   borderSide: BorderSide(color: colorScheme.primary),
  // ),
);

ThemeData lightTheme = ThemeData(
  colorScheme: colorScheme,
  textTheme: GoogleFonts.outfitTextTheme().apply(
    displayColor: Colors.black,
  ),
  appBarTheme: lightAppBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
);
