import 'package:admin_panel/core/routes/routes.dart';
import 'package:admin_panel/features/auth/view/pages/login_page.dart';
import 'package:admin_panel/features/main/view/pages/home_page.dart';
import 'package:admin_panel/features/main/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutePages {
  static final routes = [
    GetPage(name: Routes.splashPage, page: () => SplashPage()),
    GetPage(
        name: Routes.loginPage,
        page: () => LoginPage(),
        transitionDuration: Duration(seconds: 1),
        transition: Transition.cupertino),
    GetPage(
        name: Routes.homePage,
        page: () => HomePage(),
        transitionDuration: Duration(seconds: 1),
        transition: Transition.cupertino),
  ];
}
