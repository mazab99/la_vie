import 'package:flutter/material.dart';
import 'package:la_vie/models/seeds_model/seeds.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/models/seeds_model/seeds_model.dart';
import 'package:la_vie/services/dio_client.dart';

import '../utils/constants.dart';

class Seed with ChangeNotifier {
  List<Seeds> _allSeeds = [];

  List<Seeds> get allSeeds => _allSeeds;

  Future<List<Seeds?>> getAllSeeds() async {
    _allSeeds.clear();
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/seeds",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));

      SeedsModel res = SeedsModel.fromJson(response.data);
      _allSeeds = res.data!;
      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
      // if (e.response != null) {
      //   print('Dio error!');
      //   print('STATUS: ${e.response?.statusCode}');
      //   print('DATA: ${e.response?.data}');
      //   print('HEADERS: ${e.response?.headers}');
      // } else {
      //   print('Error sending request!');
      //   print(e.message);
      // }
    }
    return _allSeeds;
  }
}
