import 'package:admin_panel/config/storage/session_manager.dart';
import 'package:admin_panel/core/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../core/routes/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(splashLogo).animate(
          onComplete: (controller) {
            SessionManager().isUserLoggedIn().then((value) {
              if (value) {
                Get.offAllNamed(Routes.homePage);
              } else {
                Get.offAllNamed(Routes.loginPage);
              }
            });
          },
        ).fade(duration: Duration(seconds: 1)),
      ),
    );
  }
}
