import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/models/bin.model.dart';

class PickupDetailsTile extends StatelessWidget {
  final Bin bin;
  final ValueChanged<Bin> itemSelectedCallback;

  PickupDetailsTile({
    @required this.bin,
    @required this.itemSelectedCallback,
  });

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(bin.address),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    isDense: true,
                    icon: Text("Weight"),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                icon: Icon(Feather.eye),
                onPressed: () => itemSelectedCallback(bin),
              ),
              IconButton(icon: Icon(Feather.camera), onPressed: null),
              IconButton(icon: Icon(Feather.check), onPressed: null),
            ],
          ),
        ),
      );
}
