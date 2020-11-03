import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:werecycle/models/bin.model.dart';
import 'package:werecycle/utils/constants.dart';

class BinsProvider extends ChangeNotifier {
  Dio dio = Dio();
  static String binsURL = '${Constants.baseURL}/bins';
  List bins = [];

  BinsProvider() {
    getBins();
  }

  Future<void> getBins() async {
    var res = await dio.get(binsURL).catchError((e) {
      throw (e);
    });
    if (res.statusCode == 200) {
      bins = res.data.map((b) => Bin.fromJSON(b)).toList();
    }
    print(bins);
    notifyListeners();
  }

  // Future<void> reportBin(int id, String photo) async {}
}
