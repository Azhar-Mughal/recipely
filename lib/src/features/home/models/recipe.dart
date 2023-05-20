class Recipe {
  String? cuisineId;
  String? chef;
  String? name;
  String? id;
  String? image;
  String? categoryId;

  Recipe({
    this.cuisineId,
    this.chef,
    this.name,
    this.id,
    this.categoryId,
    this.image,
  });

  Recipe.fromJson(Map<String, dynamic> json) {
    cuisineId = json['cuisineId'];
    chef = json['chef'];
    name = json['name'];
    id = json['id'];
    image = json['image'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cuisineId'] = cuisineId;
    data['chef'] = chef;
    data['name'] = name;
    data['id'] = id;
    data['image'] = image;
    data['categoryId'] = categoryId;
    return data;
  }
}
