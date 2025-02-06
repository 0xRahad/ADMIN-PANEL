import 'package:admin_panel/config/storage/session_manager.dart';
import 'package:admin_panel/core/routes/routes.dart';
import 'package:admin_panel/core/utils/my_snack_bar.dart';
import 'package:admin_panel/features/auth/repo/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  final RxBool isLoading = false.obs;
  final authRepo = AuthRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() async {
    try {
      isLoading.value = true;
      final response = await authRepo.loginUser(
          email: emailController.text, password: passwordController.text);
      if (response.token?.isNotEmpty ?? false) {
        isLoading.value = false;
        mySnackBar(title: "Success!", body: response.message.toString());
        SessionManager().saveUser(response).then((value) {
          Get.offNamed(Routes.homePage);
        });
      } else {
        isLoading.value = false;
        mySnackBar(
            isError: true, title: "Error!", body: response.message.toString());
      }
    } catch (error) {
      isLoading.value = false;
      mySnackBar(isError: true, title: "Error!", body: error.toString());
    }
  }
}
