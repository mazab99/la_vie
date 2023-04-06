import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/models/my_forums_model/my_forums.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

import '../models/my_forums_model/my_forums_model.dart';

class MyForumsProvider with ChangeNotifier {
  List<MyForums> _myForums = [];

  List<MyForums> get myForums => _myForums;

  Future<List<MyForums?>> getMyForums() async {
    _myForums.clear();
    try {
      var response = await DioClient.dio.get(
          "${DioClient.url}/api/v1/forums/me",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      MyForumsModel res = MyForumsModel.fromJson(response.data);
      _myForums = res.data ?? [];
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
    return _myForums;
  }

  Future<MyForums?> createPost({required MyForums post}) async {
    MyForums? retrievedPost;

    try {
      Response response =
          await DioClient.dio.post("${DioClient.url}/api/v1/forums",
              data: jsonEncode({
                "title": post.title,
                "description": post.description,
                "imageBase64": post.imageUrl
              }),
              options: Options(headers: ({'Authorization': 'Bearer $token'})));

      // print('Post created: ${response.data}');

      retrievedPost = MyForums.fromJson(response.data);
      getMyForums();
    } on DioError catch (e) {
      throw e.response!.data;
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
    // print("sddddddddddddddd $retrievedPost");
    return retrievedPost;
  }
}
