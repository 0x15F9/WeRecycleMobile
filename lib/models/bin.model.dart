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

  Bin.fromJSONPickup(Map<String, dynamic> json) {
    id = json["id"];
    location = LatLng(json["bin"]["lat"], json["bin"]["lng"]);
    material = json["bin"]["material"];
    isFull = ["time"] == null;
    address = "";
  }

  String locationString() =>
      '(${location.latitude.toStringAsPrecision(4)} - ${location.longitude.toStringAsPrecision(4)})';
}
