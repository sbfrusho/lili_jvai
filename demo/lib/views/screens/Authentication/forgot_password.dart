import 'package:demo/controllers/lilli_controllers/forgot_password_controller.dart';
import 'package:demo/controllers/lilli_controllers/otp_verification_controller.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:demo/views/screens/Authentication/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller using GetX
    final controller = Get.put(ForgotPasswordController());
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;

    return CommonPage(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: verticalSpacing),

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
              "Forgot Password",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacing / 2),
            Text(
              "Enter your email to reset your password",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),

            SizedBox(height: verticalSpacing * 2),

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

            const Spacer(),

            // Send Code Button (reactive with loading state)
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              
              return CustomButton(
                title: "Send Code",
                height: 53,
                onTap: controller.isButtonEnabled.value
                    ? () async {
                        // Send reset link and navigate only on success
                        final success = await controller.sendResetLink();
                        if (success) {
                          // Pass email to OTP controller
                          final otpController = Get.put(OtpVerificationController());
                          otpController.setEmail(controller.getEmail());
                          
                          Get.to(() => const OtpVerificationScreen(), transition: .noTransition, duration: Duration(seconds: 0));
                        }
                      }
                    : null,
                width: screenWidth,
                backgroundColor: controller.isButtonEnabled.value
                    ? const Color(0xFFFFCB59).withOpacity(0.2)
                    : Colors.white.withOpacity(0.2),
              );
            }),

            SizedBox(height: verticalSpacing * 3),
          ],
        ),
      ),
    );
  }
}