import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:werecycle/main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Feather.log_out),
            onPressed: () {
              GetStorage().erase();
              runApp(MyApp());
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
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
          )
        ],
      ),
    );
  }
}
