import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/theme_config.dart';
import 'package:werecycle/views/splash.screen.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
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
      textTheme: GoogleFonts.nunitoSansTextTheme(
        theme.textTheme,
      ),
    );
  }
}
