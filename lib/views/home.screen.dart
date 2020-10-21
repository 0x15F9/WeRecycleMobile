import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/components/bin_details.bottom_sheet.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMapController controller;
  bool loaded = false;
  List<Bin> bins = [
    Bin("0", LatLng(-20.241766, 57.409693), "Bottles", false),
    Bin("1", LatLng(-20.276551, 57.426173), "Bottles", false),
    Bin("2", LatLng(-20.360260, 57.412440), "Bottles", true),
    Bin("3", LatLng(-20.443925, 57.352702), "Bottles", false),
  ];

  void onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

  final LatLng center = const LatLng(-20.330645, 57.429606);

  void _loadBins() {
    if (!loaded) {
      bins.forEach((bin) {
        controller.addSymbol(
          SymbolOptions(
            iconImage:
                bin.isFull ? "assets/full-bin.png" : "assets/empty-bin.png",
            geometry: bin.location,
          ),
          {"id": bin.id},
        );
      });
      setState(() {
        loaded = !loaded;
      });
    }
  }

  void showBottomSheet(Bin bin) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext bc) => BinDetailsBottomSheet(
        bin: bin,
      ),
    );
  }

  void _onSymbolTapped(Symbol symbol) {
    showBottomSheet(bins.firstWhere((bin) => bin.id == symbol.data["id"]));
  }

  @override
  void dispose() {
    controller?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WeRecycle"),
          actions: [
            IconButton(
              icon: Icon(Feather.user),
              onPressed: _loadBins,
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
              child: MapboxMap(
            accessToken: Constants.mapboxKey,
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(target: center, zoom: 12.5),
            styleString: MapboxStyles.MAPBOX_STREETS,
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(
              southwest: LatLng(-20.541274359910105, 57.28147899054795),
              northeast: LatLng(-19.939786566621578, 57.872003872393236),
            )),
            minMaxZoomPreference: MinMaxZoomPreference(7.5, 20),
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
          )),
        ));
  }
}
