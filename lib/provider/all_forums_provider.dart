import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:la_vie/models/all_forums_model/all_forums.dart';
import 'package:la_vie/models/all_forums_model/all_forums_model.dart';
import 'package:la_vie/services/dio_client.dart';
import 'package:la_vie/utils/constants.dart';

class AllForumsProvider with ChangeNotifier {
  List<AllForums> allForumss = [];

  List<AllForums> get allForums => allForumss;

  Future<List<AllForums?>> getAllForums() async {
    allForumss.clear();
    try {
      var response = await DioClient.dio.get("${DioClient.url}/api/v1/forums",
          options: Options(headers: ({'Authorization': 'Bearer $token'})));
      AllForumsModel res = AllForumsModel.fromJson(response.data);
      AllForumsModel fixed = AllForumsModel.fromJson({
        "type": "Success",
        "message": "Forums Fetched Successfully",
        "data": [
          {
            "forumId": "1",
            "title": "Problem",
            "description": "My plant died",
            "imageUrl": "/uploads/0481de9e-6eec-459b-ad0e-2d3e0a38a0f8.jpg",
            "userId": "8b1e67ec-ffa4-4cc2-b2cf-dd0c49b3a9f8",
            "ForumLikes": [
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              },
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              }
            ],
            "ForumComments": [
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              },
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              },
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              },
              {
                "forumId": "0481de9e-6eec-459b-ad0e-2d3e0a38a0f8",
                "userId": "2e4b988f-f87c-43f2-8ae3-ddab0a99bbad"
              }
            ],
            "user": {
              "firstName": "Ahmed",
              "lastName": "Mohamed",
              "imageUrl":
                  "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png"
            }
          },
          {
            "forumId": "680e9b12-18d2-4065-9464-6995d8f113e8",
            "title": "Beautiful",
            "description": "",
            "imageUrl": "/uploads/680e9b12-18d2-4065-9464-6995d8f113e8.jpg",
            "userId": "8b1e67ec-ffa4-4cc2-b2cf-dd0c49b3a9f8",
            "ForumLikes": [],
            "ForumComments": [],
            "user": {
              "firstName": "Amira",
              "lastName": "Ali",
              "imageUrl":
                  "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png"
            }
          },
          {
            "forumId": "c3d27ffd-e076-4574-93b3-8a72417f0ebe",
            "title": "La vie",
            "description": "Good Application about plants",
            "imageUrl": "/uploads/c3d27ffd-e076-4574-93b3-8a72417f0ebe.jpg",
            "userId": "8b1e67ec-ffa4-4cc2-b2cf-dd0c49b3a9f8",
            "ForumLikes": [],
            "ForumComments": [],
            "user": {
              "firstName": "Omar",
              "lastName": "Salah",
              "imageUrl":
                  "https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png"
            }
          }
        ]
      });
      allForumss = res.data ?? fixed.data!;
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
    return allForumss;
  }
}
