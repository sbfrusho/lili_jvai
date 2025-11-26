import 'package:demo/views/screens/submission/submission_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';

class SubmissionThanksScreen extends StatelessWidget {
  const SubmissionThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // Dynamic sizing
    double verticalSpace(double fraction) => screenHeight * fraction;
    double fontSize(double size) => size * (screenWidth / 375); // base width 375
    double radius(double r) => r * (screenWidth / 375);

    return CommonPage(
      showAppBar: true,
      text: "Add New",
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- Large SVG Image at top ---
                SvgPicture.asset(
                  "assets/icons/submission_tnx.svg",
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.7,
                  fit: BoxFit.contain,
                ),
            
                SizedBox(height: 72), // gap below image
            
                // --- Back to Home Button ---
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.065,
                  child: CustomButton(
                    title: "Back to Home",
                    backgroundColor: Colors.white.withOpacity(0.2),
                    borderRadius: radius(20),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
            
                SizedBox(height: verticalSpace(0.02)),
            
                // --- See All Submissions Text Button ---
                TextButton(
                  onPressed: () {
                    Get.to(()=>SubmissionListScreen());
                  },
                  child: Text(
                    "See all my submissions",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
