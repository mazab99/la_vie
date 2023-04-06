class MyCart {
  String? productId;
  String? userId;
  String? name;
  String? imageUrl;
  int? price;
  int count;

  MyCart(
      {this.productId,
      this.userId,
      this.name,
      this.imageUrl,
      this.price,
      required this.count});

  factory MyCart.fromJson(Map<String, dynamic> json) => MyCart(
        productId: json['productId'] as String?,
        userId: json['userId'] as String?,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
        price: json['price'] as int?,
        count: json['count'] as int,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'userId': userId,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'count': count,
      };
}
