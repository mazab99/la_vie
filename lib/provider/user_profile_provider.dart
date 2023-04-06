import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:la_vie/models/profile_model/profile_model.dart';
import 'package:la_vie/models/profile_model/user_profile.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

class UserProvider with ChangeNotifier {
  UserProfile? _userData;

  bool freeSeedAlert = false;

  UserProfile? get userData => _userData;

  void changeFreeSeedVal() {
    freeSeedAlert = !freeSeedAlert;
  }

  Future<UserProfile?> getUserData() async {
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/user/me",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      ProfileModel res = ProfileModel.fromJson(response.data);
      _userData = res.data!;
      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
    }
    return _userData;
  }

  Future addAddress(String address) async {
    try {
      await DioClient.dio.post("${DioClient.url}/api/v1/user/me/claimFreeSeeds",
          data: jsonEncode({"address": address}),
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      getUserData();
      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
    }
  }

  Future updateData(
      {required String fName,
      required String lName,
      required String email,
      required String? address}) async {
    try {
      await DioClient.dio.patch("${DioClient.url}/api/v1/user/me",
          data: jsonEncode({
            "firstName": fName,
            "lastName": lName,
            "email": email,
            "address": address
          }),
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      getUserData();
      notifyListeners();
    } on DioError catch (e) {
      throw (e.response?.data['message']);
    }
  }
}
