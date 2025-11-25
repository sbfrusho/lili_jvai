import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';

class SearchSection extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    double getResponsiveFontSize(double baseSize) {
      if (screenWidth < 360) {
        return baseSize * 0.85;
      } else if (screenWidth < 400) {
        return baseSize * 0.9;
      } else if (screenWidth > 600) {
        return baseSize * 1.1;
      }
      return baseSize;
    }

    final titleFontSize = getResponsiveFontSize(28);
    final languageFontSize = getResponsiveFontSize(16);
    final hintFontSize = getResponsiveFontSize(16);
    final suggestionFontSize = getResponsiveFontSize(15);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Search Box Container (ORIGINAL GRADIENT DESIGN) ---
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFFFCD60).withOpacity(0.5),
                const Color(0xFFFFFFFF).withOpacity(0.05),
              ],
            ),
          ),
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            children: [
              // Label + Language Switch
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.01,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.swapLanguages,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                controller.sourceLanguage.value,
                                style: TextStyle(
                                  fontSize: languageFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              SvgPicture.asset(
                                "assets/icons/swap.svg",
                                color: Colors.white,
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Text(
                                controller.targetLanguage.value,
                                style: TextStyle(
                                  fontSize: languageFontSize,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Search Input + AI Button
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Search icon inside the input
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.03,
                              right: screenWidth * 0.02,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
                              color: Colors.white.withOpacity(0.7),
                              width: 20,
                              height: 20,
                            ),
                          ),
                          // TextField
                          Expanded(
                            child: TextField(
                              controller: controller.searchController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: hintFontSize,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                hintText: "Type in English or Marshallese",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: hintFontSize,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.02,
                                  vertical: screenHeight * 0.018,
                                ),
                              ),
                            ),
                          ),
                          // Clear button and Search button inside
                          Obx(
                            () => controller.searchQuery.value.isNotEmpty
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Clear button
                                      IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 20,
                                        ),
                                        onPressed: controller.clearSearch,
                                      ),
                                      // Search button inside input
                                      GestureDetector(
                                        onTap:
                                            controller.triggerSearchIconAction,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            right: screenWidth * 0.02,
                                          ),
                                          padding: EdgeInsets.all(
                                            screenWidth * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),

                  // AI Search Icon Button (Outside)
                  GestureDetector(
                    onTap: () {
                      controller.triggerAISearch();
                    },
                    child: Container(
                      width: screenWidth * 0.13,
                      height: screenWidth * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SvgPicture.asset("assets/icons/ai_search.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        // --- Suggestion Boxes (3 clickable boxes) ---
        Obx(() {
          if (controller.searchResults.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: controller.searchResults
                .map(
                  (result) => Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: GestureDetector(
                      onTap: () => controller.selectSuggestion(result),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.018,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                result['synonym'] ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: suggestionFontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.025,
                                vertical: screenHeight * 0.006,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                result['category'] ?? '',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: suggestionFontSize * 0.85,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }),
      ],
    );
  }
}
