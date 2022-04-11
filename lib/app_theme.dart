import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final AccentColor spotifyGreen =
      AccentColor('normal', const <String, Color>{
    'darkest': Color(0xff17BF3E),
    'darker': Color(0xff17BF3E),
    'dark': Color(0xff03C03C),
    'normal': Color(0xff1DB954),
    'light': Color(0xff63B76C),
    'lighter': Color(0xff7FAC6E),
    'lightest': Color(0xff7DC683),
  });
  static ThemeData appTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    accentColor: spotifyGreen,
  );

  static TextStyle heroTextStyle = const TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
  );
}
