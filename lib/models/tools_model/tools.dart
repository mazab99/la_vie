class Tools {
  String? toolId;
  String? name;
  String? description;
  String? imageUrl;

  Tools({this.toolId, this.name, this.description, this.imageUrl});

  factory Tools.fromJson(Map<String, dynamic> json) => Tools(
        toolId: json['toolId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'toolId': toolId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
      };
}
