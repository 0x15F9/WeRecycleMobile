import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/components/bin_details.bottom_sheet.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/constants.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/views/auth.screen.dart';

class HomeScreen extends StatefulWidget {
  final bool showAppbar;
  HomeScreen({this.showAppbar: false});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMapController controller;
  bool loaded = false;
  List<Bin> bins = [
    Bin("0", LatLng(-20.241766, 57.409693), "La Valettte", "Bottles", false),
    Bin("1", LatLng(-20.276551, 57.426173), "Beaux Songes", "Bottles", false),
    Bin("2", LatLng(-20.360260, 57.412440), "Black River", "Bottles", true),
    Bin("3", LatLng(-20.443925, 57.352702), "Coteau Raffin", "Bottles", false),
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

  void _onSymbolTapped(Symbol symbol) {
    Bin bin = bins.firstWhere((bin) => bin.id == symbol.data["id"]);
    controller
        .animateCamera(CameraUpdate.newLatLng(bin.location))
        .then((_) => showBottomSheet(bin));
  }

  @override
  void dispose() {
    controller?.onSymbolTapped?.remove(_onSymbolTapped);
    super.dispose();
  }

  @override
  void initState() {
    new Timer(Duration(milliseconds: 2000), _loadBins);
    _getPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: !widget.showAppbar
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text("WeRecycle"),
                actions: [
                  IconButton(
                    icon: Icon(Feather.log_in),
                    onPressed: () => MyRouter.pushPage(context, AuthScreen()),
                  )
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

  Future<void> _getPermission() async {
    final location = Location();
    final hasPermissions = await location.hasPermission();
    _getPermission();
    if (hasPermissions != PermissionStatus.granted) {
      await location.requestPermission();
    }
  }
}
