import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/components/bin_details.tile.dart';
import 'package:werecycle/components/pickup_details.tile.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/constants.dart';

class PickupScreen extends StatefulWidget {
  final bool isRequest;

  const PickupScreen({Key key, this.isRequest: false}) : super(key: key);

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  MapboxMapController controller;
  final LatLng center = const LatLng(-20.330645, 57.429606);
  List<Bin> bins = [
    Bin("0", LatLng(-20.241766, 57.409693), "La Valettte", "Bottles", false),
    Bin("1", LatLng(-20.276551, 57.426173), "Beaux Songes", "Bottles", false),
    Bin("2", LatLng(-20.360260, 57.412440), "Black River", "Bottles", true),
    Bin("3", LatLng(-20.443925, 57.352702), "Coteau Raffin", "Bottles", false),
  ];

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
        title: Text('Pickup ${widget.isRequest ? 'Request' : 'Route'}'),
        actions: [
          widget.isRequest
              ? FlatButton.icon(
                  onPressed: () {},
                  label: Text("Accept", style: TextStyle(color: Colors.white)),
                  icon: Icon(Feather.check, color: Colors.white),
                )
              : FlatButton.icon(
                  onPressed: () {},
                  label: Text("Done", style: TextStyle(color: Colors.white)),
                  icon: Icon(Feather.check, color: Colors.white),
                ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 270,
            flexibleSpace: MapboxMap(
              // FIXME: Vertical gesture does not work
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              // TODO: on tap, center on map
              (context, index) => widget.isRequest
                  ? BinDetailsTile(bin: bins.elementAt(index))
                  : PickupDetailsTile(bin: bins.elementAt(index)),
              childCount: bins.length,
              // childCount: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
