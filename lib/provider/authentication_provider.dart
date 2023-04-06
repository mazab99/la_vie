import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/models/user_model/user.dart';
import 'package:la_vie/models/user_model/user_model.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

class Authentication with ChangeNotifier {
  User? _user;

  User? get currentUser => _user;

  Future<User?> signUp(
      {required String fName,
      required String lName,
      required String email,
      required String password}) async {
    try {
      var response = await DioClient.dio.post(
          "${DioClient.url}/api/v1/auth/signup",
          data: json.encode({
            "firstName": fName,
            "lastName": lName,
            "email": email,
            "password": password
          }));
      UserModel res = UserModel.fromJson(response.data);
      _user = res.data!.user;
      CacheHelper.setData(key: "token", value: res.data!.accessToken);
      CacheHelper.setData(key: "userId", value: res.data!.user!.userId);
      token = res.data!.accessToken;

      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
      // throw (DioExceptions.fromDioError(e).toString());
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
    return _user;
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      var response = await DioClient.dio.post(
          "${DioClient.url}/api/v1/auth/signin",
          data: jsonEncode({"password": password, "email": email}));
      UserModel res = UserModel.fromJson(response.data);
      _user = res.data!.user;
      CacheHelper.setData(key: "token", value: res.data!.accessToken);
      CacheHelper.setData(key: "userId", value: res.data!.user!.userId);
      token = res.data!.accessToken;

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
    return _user;
  }
}
