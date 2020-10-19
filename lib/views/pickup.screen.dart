import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/utils/constants.dart';

class PickupScreen extends StatefulWidget {
  final bool isRequest;

  const PickupScreen({Key key, this.isRequest: true}) : super(key: key);

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  MapboxMapController controller;
  final LatLng center = const LatLng(-20.330645, 57.429606);

  void onMapCreated(MapboxMapController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Pickup ${widget.isRequest ? 'Request' : 'Route'}')),
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Center(
            child: MapboxMap(
              accessToken: Constants.mapboxKey,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10.0,
              ),
              cameraTargetBounds: CameraTargetBounds(
                LatLngBounds(
                  southwest: LatLng(-20.523967, 57.299414),
                  northeast: LatLng(-19.970581, 57.807718),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text("3"),
        ),
      ]),
    );
  }
}
