import 'package:mapbox_gl/mapbox_gl.dart';

class Bin {
  String id;
  LatLng location;
  String address;
  String material;
  bool isFull;

  Bin(this.id, this.location, this.address, this.material, this.isFull);

  String locationString() =>
      '(${location.latitude.toStringAsPrecision(4)} - ${location.longitude.toStringAsPrecision(4)})';
}
