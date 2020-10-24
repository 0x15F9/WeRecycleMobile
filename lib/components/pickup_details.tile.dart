import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:werecycle/models/bin.model.dart';

class PickupDetailsTile extends StatefulWidget {
  final Bin bin;
  final ValueChanged<Bin> itemSelectedCallback;

  PickupDetailsTile({
    @required this.bin,
    @required this.itemSelectedCallback,
  });

  @override
  _PickupDetailsTileState createState() => _PickupDetailsTileState();
}

class _PickupDetailsTileState extends State<PickupDetailsTile> {
  final _picker = ImagePicker();
  double weight;
  File _image;

  void _takePhoto() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _send() {}

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(widget.bin.address),
          leading: _image == null // TODO: allow re taking picture
              ? IconButton(icon: Icon(Feather.camera), onPressed: _takePhoto)
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Image.file(_image, fit: BoxFit.cover),
                ),
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
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        weight = double.parse(value);
                      });
                    } else {
                      setState(() {
                        weight = null;
                      });
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              IconButton(
                icon: Icon(Feather.map_pin),
                onPressed: () => widget.itemSelectedCallback(widget.bin),
              ),
              IconButton(
                icon: Icon(Feather.check),
                onPressed: weight == null || _image == null ? null : _send,
              ),
            ],
          ),
        ),
      );
}
