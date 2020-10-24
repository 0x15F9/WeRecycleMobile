import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class NotifyFullScreen extends StatefulWidget {
  @override
  _NotifyFullScreenState createState() => _NotifyFullScreenState();
}

class _NotifyFullScreenState extends State<NotifyFullScreen> {
  int _currentStep = 0;
  final _picker = ImagePicker();
  File _image;

  void _scanQR() async {
    String result = await scanner.scan();
    // TODO:
    print(result);
    setState(() {
      _currentStep++;
    });
  }

  void _takePhoto() async {
    PickedFile image = await _picker.getImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void _next() async {
    setState(() {
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report bin"),
      ),
      body: Stepper(
        controlsBuilder: (BuildContext context,
                {VoidCallback onStepContinue, VoidCallback onStepCancel}) =>
            Container(),
        currentStep: _currentStep,
        steps: [
          Step(
            title: Text(
              'Scan QR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep == 0 ? StepState.editing : StepState.complete,
            subtitle: Text("Scan the QR Code on the bin to identify it."),
            content: RaisedButton(onPressed: _scanQR, child: Text("Scan")),
          ),
          Step(
            isActive: _currentStep >= 1,
            state: _currentStep == 1
                ? StepState.editing
                : _currentStep > 1 ? StepState.complete : StepState.indexed,
            title: Text(
              'Photo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            subtitle: Text('Show us the capacity by sending a photo'),
            content: Column(
              children: [
                if (_image != null)
                  Container(
                    height: 200,
                    child: Image.file(_image),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton.icon(
                      onPressed: _takePhoto,
                      label: Text(""),
                      icon: Icon(Feather.camera),
                    ),
                    RaisedButton(
                        onPressed: _image == null ? null : _next,
                        child: Text("Next")),
                  ],
                ),
              ],
            ),
          ),
          Step(
            isActive: _currentStep == 2,
            state: _currentStep == 2 ? StepState.editing : StepState.indexed,
            title: Text('Submit'),
            content: RaisedButton(
              onPressed: null,
              child: Text("Send"),
            ),
          ),
        ],
      ),
    );
  }
}
