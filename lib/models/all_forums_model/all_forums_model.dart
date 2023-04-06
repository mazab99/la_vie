import 'all_forums.dart';

class AllForumsModel {
  String? type;
  String? message;
  List<AllForums>? data;

  AllForumsModel({this.type, this.message, this.data});

  factory AllForumsModel.fromJson(Map<String, dynamic> json) {
    return AllForumsModel(
      type: json['type'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllForums.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
