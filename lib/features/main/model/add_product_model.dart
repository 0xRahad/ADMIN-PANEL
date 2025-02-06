// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  AddedProduct? product;
  String? message;


  AddProductModel({
    this.product,
    this.message,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    product: json["product"] == null ? null : AddedProduct.fromJson(json["product"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "message": message,
  };
}

class AddedProduct {
  String? name;
  int? price;
  String? description;
  String? image;
  String? category;
  String? company;
  List<String>? colors;
  bool? featured;
  bool? freeShipping;
  int? inventory;
  int? averageRating;
  int? numberOfReviews;
  String? user;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? productId;

  AddedProduct({
    this.name,
    this.price,
    this.description,
    this.image,
    this.category,
    this.company,
    this.colors,
    this.featured,
    this.freeShipping,
    this.inventory,
    this.averageRating,
    this.numberOfReviews,
    this.user,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productId,
  });

  factory AddedProduct.fromJson(Map<String, dynamic> json) => AddedProduct(
    name: json["name"],
    price: json["price"],
    description: json["description"],
    image: json["image"],
    category: json["category"],
    company: json["company"],
    colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
    featured: json["featured"],
    freeShipping: json["freeShipping"],
    inventory: json["inventory"],
    averageRating: json["averageRating"],
    numberOfReviews: json["numberOfReviews"],
    user: json["user"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    productId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
    "image": image,
    "category": category,
    "company": company,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "featured": featured,
    "freeShipping": freeShipping,
    "inventory": inventory,
    "averageRating": averageRating,
    "numberOfReviews": numberOfReviews,
    "user": user,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "id": productId,
  };
}
