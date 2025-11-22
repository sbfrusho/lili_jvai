import 'package:demo/controllers/otp_verification_controller.dart';
import 'package:demo/views/screens/Authentication/new_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/common_page.dart';
import 'package:demo/utils/custom_button.dart';
import 'package:get/get.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(OtpVerificationController());
    
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
              "Verify Your Account",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: verticalSpacing / 2),
            
            // Dynamic subtitle with masked email
            Obx(() {
              final email = controller.maskedEmail.value; // Use observable directly
              return Text(
                email.isNotEmpty
                    ? "Enter the 6-digit code sent to $email"
                    : "Enter the 6-digit code sent to your email",
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              );
            }),

            SizedBox(height: verticalSpacing * 2),

            // OTP Fields Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 50,
                  height: 50,
                  child: TextField(
                    controller: controller.otpControllers[index],
                    focusNode: controller.focusNodes[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {
                      if (value.isEmpty) {
                        controller.onBackspace(index);
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.white38,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFFFCB59),
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // OTP Error Message
            Obx(() => controller.otpError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      controller.otpError.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),

            SizedBox(height: verticalSpacing),

            // Resend OTP Section
            Obx(() {
              if (controller.canResend.value) {
                return Center(
                  child: TextButton(
                    onPressed: controller.resendOtp,
                    child: const Text(
                      "Didn't receive code? Resend",
                      style: TextStyle(
                        color: Color(0xFFFFCB59),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Resend code in ${controller.resendTimer.value}s",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                );
              }
            }),

            const Spacer(),

            // Verify Button with Loading State
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return CustomButton(
                title: "Verify OTP",
                height: 53,
                onTap: controller.isButtonEnabled.value
                    ? () async {
                        final success = await controller.verifyOtp();
                        if (success) {
                          Get.to(() => const NewPasswordScreen());
                        }
                      }
                    : null,
                width: screenWidth,
                backgroundColor: controller.isButtonEnabled.value
                    ? const Color(0xFFFFCB59)
                    : Colors.white24,
              );
            }),

            SizedBox(height: verticalSpacing * 3),
          ],
        ),
      ),
    );
  }
}