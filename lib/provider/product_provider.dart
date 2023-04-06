import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:la_vie/models/products_model/products.dart';
import 'package:la_vie/utils/constants.dart';

import '../models/products_model/products_model.dart';
import '../services/dio_client.dart';

class Product extends ChangeNotifier {
  List<Products> _allProducts = [];

  List<Products> get allProducts => _allProducts;

  Future<List<Products?>> getAllProducts() async {
    _allProducts.clear();
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/products",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));

      ProductsModel res = ProductsModel.fromJson(response.data);
      _allProducts = res.data!;
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
    return _allProducts;
  }
}
