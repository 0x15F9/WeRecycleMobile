import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/theme_config.dart';
import 'package:werecycle/views/splash.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: themeData(ThemeConfig.theme),
        home: SplashScreen(),
      );

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.bioRhymeTextTheme(
        theme.textTheme,
      ),
    );
  }
}
