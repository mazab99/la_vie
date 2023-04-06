class User {
  String? firstName;
  String? lastName;
  String? imageUrl;

  User({this.firstName, this.lastName, this.imageUrl});

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'imageUrl': imageUrl,
      };
}
