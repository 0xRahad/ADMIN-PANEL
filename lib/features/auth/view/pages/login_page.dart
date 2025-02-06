import 'package:admin_panel/core/themes/colors.dart';
import 'package:admin_panel/features/auth/viewmodel/auth_view_model.dart';
import 'package:admin_panel/features/widgets/custom_button.dart';
import 'package:admin_panel/features/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Get.put(AuthViewModel());

    return Scaffold(
      backgroundColor: lightGrey,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome back.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in to manage your application.",
                ),
                const Gap(20),

                /// Email Field
                CustomTextField(
                  controller: controller.emailController,
                  hintText: "Email Address",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    } else if (!GetUtils.isEmail(value.trim())) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const Gap(10),

                /// Password Field
                CustomTextField(
                  controller: controller.passwordController,
                  hintText: "Password",
                  isTextObscured: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const Gap(5),

                /// Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: deepBlue,
                      ),
                    ),
                  ),
                ),
                const Gap(5),

                /// Login Button
                Obx(
                      () => CustomButton(
                    height: 50,
                    isLoading: controller.isLoading.value,
                    buttonText: "Log in",
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        controller.loginUser();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
