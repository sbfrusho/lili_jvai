import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TranslationController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        color: Colors.white.withOpacity(0.08),
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        children: [
          // Language Row
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search",
                    style: TextStyle(
                        fontSize: screenWidth < 400 ? 20 : 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: controller.swapLanguages,
                    child: Row(
                      children: [
                        Text(controller.sourceLanguage.value,
                            style: TextStyle(
                                fontSize: screenWidth < 400 ? 16 : 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                        SizedBox(width: screenWidth * 0.015),
                        SvgPicture.asset(
                          "assets/icons/swap.svg",
                          color: Colors.white,
                          width: screenWidth * 0.04,
                          height: screenWidth * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.015),
                        Text(controller.targetLanguage.value,
                            style: TextStyle(
                                fontSize: screenWidth < 400 ? 16 : 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(height: screenHeight * 0.015),

          // Search input
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  ),
                  child: TextField(
                    controller: controller.searchController,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth < 400 ? 14 : 18),
                    decoration: InputDecoration(
                      hintText: "Type in English or Marshallese",
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: screenWidth < 400 ? 14 : 18),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          color: Colors.white.withOpacity(0.8),
                          width: screenWidth * 0.05,
                          height: screenWidth * 0.05,
                        ),
                      ),
                      suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color: Colors.white,
                                  size: screenWidth * 0.045),
                              onPressed: controller.clearSearch,
                            )
                          : const SizedBox.shrink()),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.015),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
