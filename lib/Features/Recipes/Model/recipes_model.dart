class AllRecipesModel {
  AllRecipesModel({
    required this.message,
    required this.count,
    required this.recipes,
  });

  final String? message;
  final int? count;
  final List<Recipe> recipes;

  factory AllRecipesModel.fromJson(Map<String, dynamic> json){
    return AllRecipesModel(
      message: json["message"],
      count: json["count"],
      recipes: json["recipes"] == null ? [] : List<Recipe>.from(json["recipes"]!.map((x) => Recipe.fromJson(x))),
    );
  }

}

class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? image;
  final String? url;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json["_id"],
      name: json["name"],
      image: json["image"],
      url: json["url"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

}
