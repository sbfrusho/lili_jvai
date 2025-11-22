import 'package:demo/utils/custom_text_field.dart';
import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/common_page.dart';
import 'package:demo/utils/custom_button.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/signup_controller.dart'; // Import your controller

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final SignUpController controller = Get.put(SignUpController());
    
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
              "Create Your Account",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacing / 2),
            Text(
              "Join us to bridge language barriers",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: verticalSpacing * 2),

            // Full Name Field
            CustomTextField(
              controller: controller.nameController,
              label: "Enter your full name",
              prefixSvg: "assets/icons/person.svg",
              height: 48,
            ),
            // Name Error Message
            Obx(() => controller.nameError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.nameError.value,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 12),

            // Email Field
            CustomTextField(
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
            CustomTextField(
              controller: controller.passwordController,
              label: "Enter 8+ Characters password",
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
            
            // Password Strength Indicator
            Obx(() {
              // Access observable variables at the beginning
              final strength = controller.passwordStrength.value;
              final strengthText = controller.passwordStrengthText.value;
              final passwordText = controller.currentPassword.value; // Use observable
              
              if (passwordText.isEmpty) {
                return const SizedBox.shrink();
              }
              
              Color strengthColor = Colors.red;
              if (strength > 0.6) {
                strengthColor = Colors.green;
              } else if (strength > 0.3) {
                strengthColor = Colors.orange;
              }
              
              return Padding(
                padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: strength,
                      backgroundColor: Colors.white24,
                      color: strengthColor,
                      minHeight: 4,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Password Strength: $strengthText',
                      style: TextStyle(
                        color: strengthColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: verticalSpacing),

            // Confirm Password Field
            CustomTextField(
              controller: controller.confirmPasswordController,
              label: "Re-enter your password",
              isPassword: true,
              prefixSvg: "assets/icons/lock.svg",
              height: 48,
            ),
            // Confirm Password Error Message
            Obx(() => controller.confirmPasswordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.confirmPasswordError.value,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 12),

            // Terms Checkbox
            Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: controller.agreeTerms.value,
                      onChanged: controller.toggleAgreeTerms,
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "You agree to the ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Service",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: " and acknowledge you have read the ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: verticalSpacing),

            // Sign Up Button with Loading State
            Obx(() => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : CustomButton(
                    title: "Sign Up",
                    height: 53,
                    onTap: controller.signUp,
                    width: screenWidth,
                  )),
            SizedBox(height: verticalSpacing / 2),

            // Already have an account
            GestureDetector(
              onTap: () => Get.to(() => const LoginScreen()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                  Text(
                    "Log in",
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
                Expanded(
                  child: Divider(thickness: 1, color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Or Sign Up With",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(thickness: 1, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: verticalSpacing),

            // Social Buttons
            Obx(() => controller.isLoading.value
                ? const SizedBox.shrink()
                : Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: "Google",
                          height: 48,
                          onTap: controller.signUpWithGoogle,
                          prefixImageAsset: "assets/icons/google_icon.svg",
                          width: screenWidth,
                        ),
                      ),
                      SizedBox(width: horizontalPadding / 2),
                      Expanded(
                        child: CustomButton(
                          title: "Apple",
                          height: 48,
                          onTap: controller.signUpWithApple,
                          prefixImageAsset: "assets/icons/apple_icon.svg",
                          width: screenWidth,
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