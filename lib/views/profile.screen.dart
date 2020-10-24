import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:werecycle/main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              constraints: const BoxConstraints(maxHeight: 340),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: Image.asset("assets/images/profile-image.png"),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(Feather.phone),
                    title: Text("Phone Number"),
                    subtitle: Text(GetStorage().read("phoneNumber")),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: double.infinity,
              child: OutlineButton.icon(
                label: Text("Log out"),
                icon: Icon(Feather.log_out),
                borderSide: BorderSide(color: Colors.red),
                onPressed: () {
                  GetStorage().erase();
                  runApp(MyApp());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
