import 'package:flutter/widgets.dart';
import 'package:werecycle/models/bin.model.dart';

class Pickup {
  int id;
  DateTime dateTime;
  List<Bin> bins;
  bool accepted;

  Pickup({@required this.dateTime, @required this.bins, this.accepted: false});

  Pickup.fromJSON(Map<String, dynamic> json) {
    accepted = json["status"] == "approved";
    id = json["id"];
    dateTime = DateTime.parse(json["date"]);
    bins = [];
  }
}
