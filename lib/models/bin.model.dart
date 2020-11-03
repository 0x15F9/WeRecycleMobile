import 'package:mapbox_gl/mapbox_gl.dart';

class Bin {
  int id;
  LatLng location;
  String address;
  String material;
  bool isFull;

  Bin(this.id, this.location, this.address, this.material, this.isFull);

  Bin.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    location = LatLng(json["lat"], json["lng"]);
    material = json["material"];
    isFull = json["full"];
    address = "-";
  }

  String locationString() =>
      '(${location.latitude.toStringAsPrecision(4)} - ${location.longitude.toStringAsPrecision(4)})';
}
