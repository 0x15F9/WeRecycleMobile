import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/views/auth.screen.dart';
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

    // TODO: check if first time
    // Check if logged in
    final box = GetStorage();
    String phoneNumber = box.read("phoneNumber");

    MyRouter.pushPageReplacement(
      context,
      phoneNumber == null ? AuthScreen() : MainScreen(),
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
