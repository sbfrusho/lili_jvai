import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class TranslationSection extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  TranslationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    double getFontSize(double small, double large) =>
        screenWidth < 400 ? small : large;
    FontWeight getFontWeight(double small, double large) =>
        screenWidth < 400 ? FontWeight.w400 : FontWeight.w600;

    final titleFontSize = getFontSize(20, 32);
    final titleFontWeight = getFontWeight(400, 600);

    final hintFontSize = getFontSize(14, 18);
    final hintFontWeight = getFontWeight(400, 400);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFFCD60).withOpacity(.5),
            const Color(0xFFFFFFFF).withOpacity(.05),
          ],
        ),
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Translation",
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: titleFontWeight,
              color: Colors.white,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          Container(
            width: double.infinity,
            height: screenHeight * 0.12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Obx(
              () => Text(
                controller.translationResult.value.isEmpty
                    ? "Searching"
                    : controller.translationResult.value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: hintFontSize,
                  fontWeight: hintFontWeight,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
