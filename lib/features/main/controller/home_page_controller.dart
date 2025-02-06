import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/storage/session_manager.dart';
import '../../../core/routes/routes.dart';

class HomePageController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isExpanded = false.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
    if (currentIndex.value == 3) {
      Get.back();
      showCupertinoDialog(
          context: Get.context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Sign Out"),
              content: Text("Do you really want to Log out?"),
              actions: [
                CupertinoButton(
                    child: Text("NO", style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      Get.back();
                    }),
                CupertinoButton(
                  child: Text("YES", style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    SessionManager().clearSession().then((value) {
                      Get.offAllNamed(Routes.loginPage);
                    });
                  },
                )
              ],
            );
          });
    }
  }
}
