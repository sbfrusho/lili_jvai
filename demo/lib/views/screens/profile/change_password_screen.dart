import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/change_password_controller.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return CommonPage(
      showAppBar: false,
      showBackButton: true,
      text: "Change Password",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            /// OLD PASSWORD
            CustomTextField(
              controller: controller.oldPasswordController,
              label: "Enter your old password",
              prefixSvg: "assets/icons/lock.svg",
              isPassword: true,
              height: 56,
              radius: 24,
            ),
            const SizedBox(height: 12),

            /// NEW PASSWORD
            CustomTextField(
              controller: controller.newPasswordController,
              label: "Enter your new password",
              prefixSvg: "assets/icons/lock.svg",
              isPassword: true,
              onChanged: (_) => controller.checkPasswordMatch(),
              height: 56,
              radius: 24,
            ),
            const SizedBox(height: 12),

            /// CONFIRM PASSWORD
            CustomTextField(
              controller: controller.confirmPasswordController,
              label: "Confirm new password",
              prefixSvg: "assets/icons/lock.svg",
              isPassword: true,
              onChanged: (_) => controller.checkPasswordMatch(),
              height: 56,
              radius: 24,
            ),
            const SizedBox(height: 12),

            /// PASSWORD MATCH CHECKBOX
            Obx(() => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.passwordMatch.value =
                            !controller.passwordMatch.value;
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: controller.passwordMatch.value
                            ? Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "Passwords match",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                )),

            SizedBox(height: MediaQuery.of(context).size.height * 0.15),

            /// SAVE BUTTON
            CustomButton(
              title: "Save Now",
              onTap: controller.savePassword,
              height: 56,
              width: double.infinity,
              backgroundColor: Colors.white.withOpacity(0.2),
              borderRadius: 12,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
following the same architecture make a change password screen
there will be 3 fields..
Enter your old password
Enter you new password
Confirm new password
below there is a circular checkbox + Password match

give some space and a button Save Now..
make a controller, use getX and my custom button, custom textfield and commmon page
 */