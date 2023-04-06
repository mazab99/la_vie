class ForumLikes {
  String? forumId;
  String? userId;

  ForumLikes({this.forumId, this.userId});

  ForumLikes.fromJson(Map<String, dynamic> json) {
    forumId = json['forumId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() => {
        'forumId': forumId,
        'userId': userId,
      };
}
