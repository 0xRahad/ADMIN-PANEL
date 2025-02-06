import 'package:flutter/material.dart';
import 'package:get/get.dart';

void mySnackBar({
  required String title,
  required String body,
  bool isError = false
}) {
  Get.snackbar(title, body,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Colors.red : Colors.blueAccent,
      borderRadius: 10,
      margin: EdgeInsets.all(20),
      maxWidth: 400,
      icon: Icon(
        Icons.notifications,
        size: 30,
        color: Colors.white,
      ),
      mainButton: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Ok",
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold))));
}