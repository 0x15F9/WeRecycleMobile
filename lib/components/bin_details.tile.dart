import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:werecycle/models/bin.model.dart';

class BinDetailsTile extends StatelessWidget {
  final Bin bin;
  final ValueChanged<Bin> itemSelectedCallback;

  BinDetailsTile({
    @required this.bin,
    @required this.itemSelectedCallback,
  });

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(bin.address),
          subtitle: Text('Material: ${bin.material}'),
          trailing: Icon(Feather.map_pin),
          onTap: () => itemSelectedCallback(bin),
        ),
      );
}
