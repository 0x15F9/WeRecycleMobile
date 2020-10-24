import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:werecycle/components/pickup_request.tile.dart';
import 'package:werecycle/models/pickup.model.dart';
import 'package:werecycle/models/bin.model.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Pickup> pickups = [
    Pickup(
      dateTime: DateTime(2020, 11, 20),
      bins: [
        Bin("0", LatLng(-20.241766, 57.409693), "La Valettte", "Bottles",
            false),
        Bin("1", LatLng(-20.276551, 57.426173), "Beaux Songes", "Bottles",
            false),
      ],
    ),
    Pickup(
      dateTime: DateTime(2020, 11, 10),
      bins: [
        Bin("2", LatLng(-20.360260, 57.412440), "Black River", "Bottles", true),
        Bin("3", LatLng(-20.443925, 57.352702), "Coteau Raffin", "Bottles",
            false),
      ],
      accepted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            PickupRequestTile(pickup: pickups.elementAt(index)),
        itemCount: pickups.length,
      ),
    );
  }
}
