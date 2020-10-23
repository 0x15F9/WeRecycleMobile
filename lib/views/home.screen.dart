import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final bool showAppbar;

  HomeScreen({this.showAppbar: false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !showAppbar ? null : AppBar(),
      body: Center(child: Text("Home")),
    );
  }
}
