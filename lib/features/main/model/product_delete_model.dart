// To parse this JSON data, do
//
//     final productDeleteModel = productDeleteModelFromJson(jsonString);

import 'dart:convert';

ProductDeleteModel productDeleteModelFromJson(String str) => ProductDeleteModel.fromJson(json.decode(str));

String productDeleteModelToJson(ProductDeleteModel data) => json.encode(data.toJson());

class ProductDeleteModel {
  String? message;

  ProductDeleteModel({
    this.message,
  });

  factory ProductDeleteModel.fromJson(Map<String, dynamic> json) => ProductDeleteModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
