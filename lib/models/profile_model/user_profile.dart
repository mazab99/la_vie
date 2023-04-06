class UserProfile {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  String? address;
  String? role;
  int? userPoints;
  List<dynamic>? userNotification;

  UserProfile({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.address,
    this.role,
    this.userPoints,
    this.userNotification,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json['userId'] as String?,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        imageUrl: json['imageUrl'] as String?,
        address: json['address'] as String?,
        role: json['role'] as String?,
        userPoints: json['UserPoints'] as int?,
        userNotification: json['UserNotification'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
        'address': address,
        'role': role,
        'UserPoints': userPoints,
        'UserNotification': userNotification,
      };
}
