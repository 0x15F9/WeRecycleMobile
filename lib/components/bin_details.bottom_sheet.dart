import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/theme_config.dart';

class BinDetailsBottomSheet extends StatelessWidget {
  final Bin bin;

  BinDetailsBottomSheet({@required this.bin});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            leading: IconButton(
              icon: Icon(Feather.arrow_left),
              onPressed: Navigator.of(context).pop,
              color: ThemeConfig.lightPrimary,
            ),
            centerTitle: true,
            title: Text(
              "Bin Details",
              style: TextStyle(color: ThemeConfig.lightAccent),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [IconButton(icon: Icon(Feather.bell), onPressed: null)],
          ),
          Card(
            child: ListTile(
              title: Text("Material"),
              subtitle: Text(bin.material),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Capacity"),
              subtitle: Text(bin.isFull ? "Full" : "Not full"),
              trailing: Image.asset(
                bin.isFull ? "assets/full-bin.png" : "assets/empty-bin.png",
                scale: 2,
              ),
            ),
          ),
        ],
      );
}
