import 'package:la_vie/models/my_forums_model/my_forums.dart';

import 'my_forums.dart';

class MyForumsModel {
  String? type;
  String? message;
  List<MyForums>? data;

  MyForumsModel({this.type, this.message, this.data});

  factory MyForumsModel.fromJson(Map<String, dynamic> json) {
    return MyForumsModel(
      type: json['type'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyForums.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
