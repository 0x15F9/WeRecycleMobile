import 'package:flutter/widgets.dart';
import 'package:werecycle/models/bin.model.dart';

class Pickup {
  DateTime dateTime;
  List<Bin> bins;
  bool accepted;

  Pickup({@required this.dateTime, @required this.bins, this.accepted: false});
}
