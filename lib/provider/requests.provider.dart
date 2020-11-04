import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/models/pickup.model.dart';
import 'package:werecycle/utils/constants.dart';

class RequestProvider extends ChangeNotifier {
  bool loading = true;
  Dio dio = new Dio();
  String phoneNumber = GetStorage().read("phoneNumber");
  List<Pickup> pickups = [];

  RequestProvider() {
    getRequests();
  }

  Future<void> getRequests() async {
    var res = await dio.get('${Constants.baseURL}/pickups/driverallocations',
        queryParameters: {"phoneNumber": phoneNumber});
    pickups = [];
    if (res.statusCode == 200) {
      for (var r in res.data) {
        Pickup p = Pickup.fromJSON(r["pickups"]);
        p.bins = [];
        for (var b in r["pickupBins"]) {
          p.bins.add(Bin.fromJSONPickup(b));
        }

        pickups.add(p);
      }
      loading = false;
      notifyListeners();
    }
  }
}
