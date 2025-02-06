import 'package:admin_panel/config/storage/session_manager.dart';
import 'package:admin_panel/core/consts/images.dart';
import 'package:admin_panel/features/main/controller/home_page_controller.dart';
import 'package:admin_panel/features/main/view/pages/manage_product_page.dart';
import 'package:admin_panel/features/main/view/pages/manage_user_page.dart';
import 'package:admin_panel/features/main/view/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        leading: IconButton(onPressed: () {
          controller.isExpanded.value = !controller.isExpanded.value;
        }, icon: Icon(Icons.menu)),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Theme(
              data: ThemeData(useMaterial3: false),
              child: Obx(() => NavigationRail(
                  extended: controller.isExpanded.value,
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
                        label: Text("Users")
                    ),

                    NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        label: Text("Settings")
                    ),

                    NavigationRailDestination(
                        icon: Icon(Icons.logout_outlined),
                        label: Text("Log out")
                    ),
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

