// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? message;
  String? token;

  LoginModel({
    this.message,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
  };
}
