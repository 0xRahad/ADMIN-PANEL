// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  int? count;
  List<Product>? products;
  int? currentPage;
  int? totalPages;

  ProductsModel({
    this.count,
    this.products,
    this.currentPage,
    this.totalPages,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    count: json["count"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class Product {
  String? id;
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
  String? createdAt;
  String? updatedAt;
  int? v;
  String? productId;

  Product({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.productId,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
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
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    productId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "id": productId,
  };
}
