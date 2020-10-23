import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Profile"),
                ),
                Container(
                  constraints: const BoxConstraints(maxHeight: 340),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Image.asset("assets/images/profile-image.png"),
                ),
              ],
            ),
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
        )
      ],
    );
  }
}
