import 'package:flutter/material.dart';
import 'package:la_vie/models/plants_model/plants_model.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';
import '../models/plants_model/plants.dart';

class Plant with ChangeNotifier {
  List<Plants> _allPlants = [];

  List<Plants> get allPlants => _allPlants;

  Future<List<Plants?>> getAllPlants() async {
    _allPlants.clear();
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/plants",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      PlantsModel res = PlantsModel.fromJson(response.data);
      _allPlants = res.data!;
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
    return _allPlants;
  }
}
