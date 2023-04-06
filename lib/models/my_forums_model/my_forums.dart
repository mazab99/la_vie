import 'forum_comment.dart';
import 'forum_like.dart';
import 'user.dart';

class MyForums {
  String? forumId;
  String? title;
  String? description;
  String? imageUrl;
  String? userId;
  List<ForumLikes>? forumLikes;
  List<ForumComments>? forumComments;
  User? user;

  MyForums({
    this.forumId,
    this.title,
    this.description,
    this.imageUrl,
    this.userId,
    this.forumLikes,
    this.forumComments,
    this.user,
  });

  factory MyForums.fromJson(Map<String, dynamic> json) => MyForums(
        forumId: json['forumId'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        userId: json['userId'] as String?,
        forumLikes: (json['ForumLikes'] as List<dynamic>?)
            ?.map((e) => ForumLikes.fromJson(e as Map<String, dynamic>))
            .toList(),
        forumComments: (json['ForumComments'] as List<dynamic>?)
            ?.map((e) => ForumComments.fromJson(e as Map<String, dynamic>))
            .toList(),
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'userId': userId,
        'ForumLikes': forumLikes?.map((e) => e.toJson()).toList(),
        'ForumComments': forumComments?.map((e) => e.toJson()).toList(),
        'user': user?.toJson(),
      };
}
