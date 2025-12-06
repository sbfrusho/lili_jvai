import 'package:demo/controllers/lilli_controllers/signup_controller.dart';
import 'package:demo/utils/lilli_utils/custom_tex_field_auth.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:demo/views/screens/Authentication/forgot_password.dart';
import 'package:demo/views/screens/Authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/login_controller.dart'; // Import your controller

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final LoginController controller = Get.put(LoginController());
    final SignUpController signUpController = Get.put(SignUpController());
    // controller.clearFields();
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;
    

    return CommonPage(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalSpacing,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo and Back Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icons/1.png", width: 64, height: 40),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    "assets/icons/back_button.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
            SizedBox(height: verticalSpacing),

            // Header
            Text(
              "Hello!",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacing / 2),
            Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacing * 2),

            // Email Field
            CustomTextFieldAuth (
              controller: controller.emailController,
              label: "Enter your email",
              prefixSvg: "assets/icons/email.svg",
              height: 48,
            ),
            // Email Error Message
            Obx(() => controller.emailError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.emailError.value,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 12),

            // Password Field
            CustomTextFieldAuth (
              controller: controller.passwordController,
              label: "Enter your password",
              isPassword: true,
              prefixSvg: "assets/icons/lock.svg",
              height: 48,
            ),
            // Password Error Message
            Obx(() => controller.passwordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.passwordError.value,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 8),

            // Forgot Password link
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Get.to(() => ForgotPasswordScreen(), transition: .noTransition, duration: Duration(seconds: 0)),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.035,
                  ),
                ),
              ),
            ),
            SizedBox(height: verticalSpacing),

            // Login Button with Loading State
            Obx(() => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : CustomButton(
                    title: "Log In",
                    height: 53,
                    onTap: controller.login,
                    width: screenWidth,
                  )),
            SizedBox(height: verticalSpacing / 2),

            // Sign Up link
            GestureDetector(
              onTap: () {
                signUpController.clearFields();
                Get.to(() => const SignUpScreen(), transition: .noTransition, duration: Duration(seconds: 0));

              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You don't have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: verticalSpacing * 2),

            // Divider
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1, color: Colors.white)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or Login With",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(child: Divider(thickness: 1, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 50),

            // Social Buttons
            Obx(() => controller.isLoading.value
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: "Google",
                          height: 48,
                          onTap: controller.loginWithGoogle,
                          prefixImageAsset: "assets/icons/google_icon.svg",
                          width: screenWidth,
                          backgroundOpacity: 0,
                        ),
                      ),
                      SizedBox(width: horizontalPadding / 2),
                      Expanded(
                        child: CustomButton(
                          title: "Apple",
                          height: 48,
                          onTap: controller.loginWithApple,
                          prefixImageAsset: "assets/icons/apple_icon.svg",
                          width: screenWidth,
                          backgroundOpacity: 0,
                        ),
                      ),
                    ],
                  )),
            SizedBox(height: verticalSpacing * 3),
          ],
        ),
      ),
    );
  }
}