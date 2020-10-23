import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/models/bin.model.dart';

class BinDetailsTile extends StatelessWidget {
  final Bin bin;

  BinDetailsTile({@required this.bin});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(bin.address),
          subtitle: Text('Material: ${bin.material}'),
          trailing: Icon(Feather.map_pin),
        ),
      );
}
