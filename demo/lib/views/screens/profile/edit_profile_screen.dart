import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/edit_profile_controller.dart';
import 'package:demo/utils/lilli_utils/dotted_circle_painter.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());

    final screenHeight = MediaQuery.of(context).size.height;

    return CommonPage(
      showAppBar: true,
      text: "Edit Profile",
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            /// PROFILE IMAGE WITH DOTTED BORDER
            Center(
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(130, 130),
                    painter: DottedCirclePainter(),
                    child: Container(
                      width: 130,
                      height: 130,
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/icons/person_1.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  /// UPLOAD ICON
                  Positioned( 
                    bottom: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCB59),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.05),

            /// FULL NAME FIELD
            CustomTextField(
              controller: controller.fullNameController,
              label: "Enter your full name",
              prefixSvg: "assets/icons/person.svg",
              height: 56,
              
            ),

            SizedBox(height: screenHeight * 0.08), // responsive spacing

            /// SAVE BUTTON
            CustomButton(
              title: "Save",
              onTap: controller.saveProfile,
              height: 56,
              width: double.infinity,
              backgroundColor: Colors.white.withOpacity(0.2),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
