import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/views/auth.screen.dart';
import 'package:werecycle/views/profile.screen.dart';

class HomeScreen extends StatelessWidget {
  final bool showAppbar;

  HomeScreen({this.showAppbar: false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !showAppbar
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text("WeRecycle"),
              actions: [
                IconButton(
                  icon: Icon(Feather.log_in),
                  onPressed: () => MyRouter.pushPage(context, AuthScreen()),
                )
              ],
            ),
      body: Center(child: Text("Home")),
    );
  }
}
