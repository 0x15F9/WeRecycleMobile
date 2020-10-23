import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/models/bin.model.dart';

class PickupDetailsTile extends StatelessWidget {
  final Bin bin;

  PickupDetailsTile({@required this.bin});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(bin.address),
          subtitle: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
              isDense: true,
              icon: Text("Weight"),
            ),
            keyboardType: TextInputType.number,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(icon: Icon(Feather.camera), onPressed: null),
              IconButton(icon: Icon(Feather.check), onPressed: null),
            ],
          ),
        ),
      );
}
