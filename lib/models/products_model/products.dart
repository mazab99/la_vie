import '../plants_model/plants.dart';
import '../seeds_model/seeds.dart';
import '../tools_model/tools.dart';

class Products {
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  Seeds? seed;
  Plants? plant;
  Tools? tool;

  Products({
    this.productId,
    this.name,
    this.description,
    this.imageUrl,
    this.type,
    this.price,
    this.available,
    this.seed,
    this.plant,
    this.tool,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json['productId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        type: json['type'] as String?,
        price: json['price'] as int?,
        available: json['available'] as bool?,
        seed: json['seed'] == null
            ? null
            : Seeds.fromJson(json['seed'] as Map<String, dynamic>),
        plant: json['plant'] == null
            ? null
            : Plants.fromJson(json['plant'] as Map<String, dynamic>),
        tool: json['tool'] == null
            ? null
            : Tools.fromJson(json['tool'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'type': type,
        'price': price,
        'available': available,
        'seed': seed,
        'plant': plant?.toJson(),
        'tool': tool,
      };
}
