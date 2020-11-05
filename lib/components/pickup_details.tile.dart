import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/theme_config.dart';

class PickupDetailsTile extends StatefulWidget {
  final Bin bin;
  final int pickupId;
  final ValueChanged<Bin> itemSelectedCallback;

  PickupDetailsTile({
    @required this.pickupId,
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

  void _send() async {
    setState(() {
      widget.bin.isFull = true;
    });
    widget.bin.weight = weight;
    Dio dio = new Dio();
    Uint8List imgBytes = await _image.readAsBytes();
    String img = base64Encode(imgBytes);
    var d = {
      "id": widget.pickupId,
      "binId": widget.bin.id,
      "weight": weight,
      "image": img,
    };
    await dio.post(
      '${Constants.baseURL}/PickupBins',
      data: d,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
  }

  @override
  Widget build(BuildContext context) => Card(
        color:
            widget.bin.isFull ? ThemeConfig.lightAccent.withOpacity(0.5) : null,
        child: ListTile(
          title: widget.bin.isFull ? Text(widget.bin.address) : null,
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
                child: widget.bin.isFull
                    ? Text(
                        widget.bin.weight.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ThemeConfig.lightPrimary,
                        ),
                      )
                    : TextFormField(
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
              // if (!widget.bin.isFull)
              IconButton(
                icon: Icon(Feather.check),
                onPressed: weight == null || _image == null ? null : _send,
              ),
            ],
          ),
        ),
      );
}
