import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class TranslationResultWidget extends StatelessWidget {
  const TranslationResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslationController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        color: Colors.white.withOpacity(0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Translation",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: screenHeight * 0.015),
          Container(
            width: double.infinity,
            height: screenHeight * 0.12,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Obx(() => Text(
                  controller.translationResult.value.isEmpty
                      ? "Searching"
                      : controller.translationResult.value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth < 400 ? 14 : 18,
                      fontWeight: FontWeight.w400),
                )),
          ),
        ],
      ),
    );
  }
}
