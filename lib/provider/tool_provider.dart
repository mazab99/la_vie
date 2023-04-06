import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

import '../models/tools_model/tools.dart';
import '../models/tools_model/tools_model.dart';

class Tool with ChangeNotifier {
  List<Tools> _allTools = [];

  List<Tools> get allTools => _allTools;

  Future<List<Tools?>> getAllTools() async {
    _allTools.clear();
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/tools",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));

      ToolsModel res = ToolsModel.fromJson(response.data);
      _allTools = res.data!;
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
    return _allTools;
  }
}
