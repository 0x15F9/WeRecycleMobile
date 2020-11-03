import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:werecycle/provider/bins.provider.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/views/auth.screen.dart';
import 'package:werecycle/views/home.screen.dart';
import 'package:werecycle/views/main.screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout() {
    return new Timer(Duration(seconds: 1), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    await GetStorage.init();
    await Firebase.initializeApp();

    final box = GetStorage();
    // TODO: also check user type
    // Check if first time
    bool firstTime = box.read("firstTime") ?? true;
    box.write("firstTime", false);
    // Check if logged in
    String phoneNumber = box.read("phoneNumber");

    MyRouter.pushPageReplacement(
      context,
      firstTime
          ? AuthScreen()
          : phoneNumber == null
              ? MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (context) => BinsProvider()),
                  ],
                  child: HomeScreen(showAppbar: true),
                )
              : MainScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(Constants.appName),
          ],
        ),
      ),
    );
  }
}
