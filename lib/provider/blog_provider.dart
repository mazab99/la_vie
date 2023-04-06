import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/models/plants_model/plants.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

import '../models/blogs_model/blogs_model.dart';

class Blog with ChangeNotifier {
  List<Plants> _allBlogs = [];

  List<Plants> get allBlogs => _allBlogs;

  Future<List<Plants>> getAllBlogs() async {
    _allBlogs.clear();
    try {
      var response = await DioClient.dio.get(
          "${DioClient.url}/api/v1/products/blogs",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));

      BlogsModel res = BlogsModel.fromJson(response.data);
      _allBlogs = res.data!.plants!;
      for (var item in res.data!.seeds!) {
        _allBlogs.add(Plants(
            plantId: item.seedId,
            name: item.name,
            description: item.description,
            imageUrl: item.imageUrl));
      }
      for (var item in res.data!.tools!) {
        _allBlogs.add(Plants(
            plantId: item.toolId,
            name: item.name,
            description: item.description,
            imageUrl: item.imageUrl));
      }
      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
    }
    return _allBlogs;
  }
}
