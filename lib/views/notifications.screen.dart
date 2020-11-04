import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:werecycle/components/pickup_request.tile.dart';
import 'package:werecycle/models/pickup.model.dart';
import 'package:werecycle/utils/theme_config.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Pickup> pickups;
  final bool loading;
  NotificationsScreen({@required this.pickups, this.loading = true});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? Center(
              child: SpinKitThreeBounce(
              color: ThemeConfig.lightAccent,
              size: 50,
            ))
          : pickups.isEmpty
              ? Center(
                  child: Text("No Notifications at this time",
                      style: TextStyle(
                        color: ThemeConfig.lightAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )))
              : ListView.builder(
                  itemBuilder: (context, index) =>
                      PickupRequestTile(pickup: pickups.elementAt(index)),
                  itemCount: pickups.length,
                ),
    );
  }
}
