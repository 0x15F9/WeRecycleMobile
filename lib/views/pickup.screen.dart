import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/components/bin_details.tile.dart';
import 'package:werecycle/components/pickup_details.tile.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/models/pickup.model.dart';
import 'package:werecycle/utils/constants.dart';

class PickupScreen extends StatefulWidget {
  final Pickup pickup;

  const PickupScreen({Key key, @required this.pickup}) : super(key: key);

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  MapboxMapController controller;
  final LatLng center = const LatLng(-20.330645, 57.429606);

  void onMapCreated(MapboxMapController controller) {
    this.controller = controller;
    controller.onSymbolTapped.add(_onSymbolTapped);
  }

  @override
  void initState() {
    new Timer(Duration(milliseconds: 1000), _loadBins);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pickup.accepted ? 'Details' : 'Request'),
        actions: [
          widget.pickup.accepted
              ? FlatButton.icon(
                  onPressed: () {},
                  label: Text("Done", style: TextStyle(color: Colors.white)),
                  icon: Icon(Feather.check, color: Colors.white),
                )
              : FlatButton.icon(
                  onPressed: () {},
                  label: Text("Accept", style: TextStyle(color: Colors.white)),
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
              (context, index) => widget.pickup.accepted
                  ? PickupDetailsTile(
                      bin: widget.pickup.bins.elementAt(index),
                      itemSelectedCallback: (_) =>
                          _onTileTapped(widget.pickup.bins.elementAt(index)),
                    )
                  : BinDetailsTile(
                      bin: widget.pickup.bins.elementAt(index),
                      itemSelectedCallback: (_) =>
                          _onTileTapped(widget.pickup.bins.elementAt(index)),
                    ),
              childCount: widget.pickup.bins.length,
            ),
          ),
        ],
      ),
    );
  }

  void _loadBins() {
    widget.pickup.bins.forEach((bin) {
      controller.addSymbol(
        SymbolOptions(
          iconImage:
              bin.isFull ? "assets/full-bin.png" : "assets/empty-bin.png",
          geometry: bin.location,
        ),
        {"id": bin.id},
      );
    });
  }

  void _onSymbolTapped(Symbol symbol) {
    Bin bin =
        widget.pickup.bins.firstWhere((bin) => bin.id == symbol.data["id"]);
    // TODO: zoom more
    controller.animateCamera(CameraUpdate.newLatLng(bin.location));
  }

  void _onTileTapped(Bin bin) {
    // TODO: make different from other: enlarge, or encircle
    controller.animateCamera(CameraUpdate.newLatLng(bin.location));
  }
}
