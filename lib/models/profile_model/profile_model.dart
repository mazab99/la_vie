import 'user_profile.dart';

class ProfileModel {
  String? type;
  String? message;
  UserProfile? data;

  ProfileModel({this.type, this.message, this.data});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        type: json['type'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : UserProfile.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.toJson(),
      };
}
