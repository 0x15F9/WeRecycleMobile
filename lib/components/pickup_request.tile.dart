import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:werecycle/models/pickup.model.dart';
import 'package:werecycle/utils/router.dart';
import 'package:werecycle/utils/theme_config.dart';
import 'package:werecycle/views/pickup.screen.dart';

class PickupRequestTile extends StatelessWidget {
  final Pickup pickup;

  PickupRequestTile({@required this.pickup});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Card(
        color: pickup.accepted
            ? ThemeConfig.lightAccent.withOpacity(0.5)
            : Colors.orange.withOpacity(0.5),
        child: ListTile(
          leading: Icon(
            pickup.accepted ? Feather.check_circle : Feather.alert_circle,
          ),
          title: Text('Pickup ${pickup.accepted ? "Details" : "Request"}'),
          subtitle:
              Text('on ' + DateFormat("dd MMM yyyy").format(pickup.dateTime)),
          trailing: Icon(Feather.arrow_right),
          onTap: () => MyRouter.pushPage(context, PickupScreen(pickup: pickup)),
        ),
      ),
    );
  }
}
