import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.yellow,
      );
}

class Styles {
  static final titleTextStyle = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final bodyTextStyle = GoogleFonts.lato(
    fontSize: 16,
  );

  static final detailLabelTextStyle = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final detailValueTextStyle = GoogleFonts.lato(
    fontSize: 18,
  );

  static final subtitleTextStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 16,
  );

  static const cardTitleTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
