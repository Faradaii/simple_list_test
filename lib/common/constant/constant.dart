import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color cPrimaryColor = Color(0xFF2B637B); //#2B637B
const Color cOnPrimaryColor = Color(0xFF04021D); //#04021D
const Color cOnSecondaryColor = Color(0xFF686777); //#686777
const Color kPurple = Color(0xFF554AF0); //#554AF0
const Color kGray = Color(0xFF686777); //#686777
const Color kLightGray = Color(0xFFE2E3E4); //#E2E3E4

final TextStyle kHeading1 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: cOnPrimaryColor,
);
final TextStyle kHeading2 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: cOnPrimaryColor,
);
final TextStyle kHeading3 = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: cOnPrimaryColor,
);

final TextStyle kBodyText1 = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);
final TextStyle kBodyText2 = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
);
final TextStyle kBodyText3 = GoogleFonts.poppins(
  fontSize: 10,
  fontWeight: FontWeight.w500,
);

const kColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: cPrimaryColor,
    onPrimary: cOnPrimaryColor,
    secondary: Colors.white,
    onSecondary: cOnSecondaryColor,
    error: Colors.red,
    onError: Colors.white,
    surface: cPrimaryColor,
    onSurface: Colors.white);

final kTextTheme = TextTheme(
  headlineLarge: kHeading1,
  headlineMedium: kHeading2,
  headlineSmall: kHeading3,
  bodyLarge: kBodyText1,
  bodyMedium: kBodyText2,
  bodySmall: kBodyText3,
);
