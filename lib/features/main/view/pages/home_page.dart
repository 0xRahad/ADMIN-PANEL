import 'package:admin_panel/config/storage/session_manager.dart';
import 'package:admin_panel/features/main/controller/home_page_controller.dart';
import 'package:admin_panel/features/main/view/pages/manage_product_page.dart';
import 'package:admin_panel/features/main/view/pages/manage_user_page.dart';
import 'package:admin_panel/features/main/view/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/routes/routes.dart';
import '../../../widgets/screen_size.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
        leading: !ScreenSize.isMobile(context)
            ? null
            : IconButton(
                onPressed: () {
                  controller.isExpanded.value = !controller.isExpanded.value;
                },
                icon: Icon(Icons.menu)),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                    context: Get.context!,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text("Sign Out"),
                        content: Text("Do you really want to Log out?"),
                        actions: [
                          CupertinoButton(
                              child: Text("NO",
                                  style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                Get.back();
                              }),
                          CupertinoButton(
                            child: Text("YES",
                                style: TextStyle(color: Colors.black)),
                            onPressed: () {
                              SessionManager().clearSession().then((value) {
                                Get.offAllNamed(Routes.loginPage);
                              });
                            },
                          )
                        ],
                      );
                    });
              },
              icon: Icon(Icons.logout_outlined)),
          Gap(10),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            Theme(
              data: ThemeData(useMaterial3: false),
              child: Obx(() => NavigationRail(
                  extended: !ScreenSize.isMobile(context)
                      ? true
                      : controller.isExpanded.value,
                  backgroundColor: Colors.white,
                  onDestinationSelected: (value) {
                    controller.changeIndex(value);
                  },
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.inventory_2_outlined),
                      label: Text("Products"),
                    ),
                    NavigationRailDestination(
                        icon: Icon(Icons.manage_accounts_outlined),
                        label: Text("Users")),
                    NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        label: Text("Settings"))
                  ],
                  selectedIndex: controller.currentIndex.value)),
            ),
            Expanded(
              flex: 5,
              child: Obx(() {
                switch (controller.currentIndex.value) {
                  case 0:
                    return ManageProductPage();
                  case 1:
                    return ManageUserPage();
                  case 2:
                    return SettingsPage();
                  default:
                    return Container();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
