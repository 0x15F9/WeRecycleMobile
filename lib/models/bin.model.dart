import 'package:mapbox_gl/mapbox_gl.dart';

class Bin {
  String id;
  LatLng location;
  String material;
  bool isFull;

  Bin(this.id, this.location, this.material, this.isFull);
}
