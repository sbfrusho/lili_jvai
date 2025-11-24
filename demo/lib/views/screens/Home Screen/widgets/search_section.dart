// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:demo/controllers/translation_home_controller.dart';

// class SearchSection extends StatelessWidget {
//   SearchSection({super.key});

//   final TranslationController controller = Get.find<TranslationController>();

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(screenWidth * 0.05),
//       ),
//       padding: EdgeInsets.all(screenWidth * 0.05),

//       child: Column(
//         children: [
//           _buildSearchHeader(screenWidth, screenHeight),
//           SizedBox(height: screenHeight * 0.015),
//           _buildSearchInput(screenWidth, screenHeight),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchHeader(double screenWidth, double screenHeight) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.04,
//         vertical: screenHeight * 0.015,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Search",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
//           ),
//           Obx(() => GestureDetector(
//                 onTap: controller.swapLanguages,
//                 child: Row(
//                   children: [
//                     Text(controller.sourceLanguage.value,
//                         style: const TextStyle(color: Colors.white)),
//                     SizedBox(width: screenWidth * 0.015),
//                     SvgPicture.asset("assets/icons/swap.svg",
//                         width: screenWidth * 0.04, color: Colors.white),
//                     SizedBox(width: screenWidth * 0.015),
//                     Text(controller.targetLanguage.value,
//                         style: const TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchInput(double screenWidth, double screenHeight) {
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(screenWidth * 0.03),
//             ),
//             child: TextField(
//               controller: controller.searchController,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: "Type in English or Marshallese",
//                 hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.all(screenWidth * 0.02),
//                   child: SvgPicture.asset(
//                     "assets/icons/search.svg",
//                     color: Colors.white.withOpacity(0.8),
//                   ),
//                 ),
//                 suffixIcon: Obx(
//                   () => controller.searchQuery.value.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(Icons.clear, color: Colors.white),
//                           onPressed: controller.clearSearch,
//                         )
//                       : const SizedBox(),
//                 ),
//                 border: InputBorder.none,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: screenWidth * 0.02),
//         GestureDetector(
//           onTap: () {
//             Get.snackbar("Clicked", "Button Pressed",
//                 backgroundColor: Colors.blue, colorText: Colors.white);
//           },
//           child: Container(
//             width: screenWidth * 0.12,
//             height: screenWidth * 0.12,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(screenWidth * 0.03),
//             ),
//             child: SvgPicture.asset("assets/icons/app_bar.svg"),
//           ),
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class SearchSection extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  SearchSection({super.key});

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

    final languageFontSize = getFontSize(16, 20);
    final languageFontWeight = getFontWeight(400, 600);

    final hintFontSize = getFontSize(14, 18);
    final hintFontWeight = getFontWeight(400, 400);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- Search Box Container ---
        Container(
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
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              // Label + Language Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: titleFontWeight,
                      color: Colors.white,
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: controller.swapLanguages,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.sourceLanguage.value,
                            style: TextStyle(
                              fontSize: languageFontSize,
                              fontWeight: languageFontWeight,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          SvgPicture.asset(
                            "assets/icons/swap.svg",
                            color: Colors.white,
                            width: screenWidth * 0.04,
                            height: screenWidth * 0.04,
                          ),
                          SizedBox(width: screenWidth * 0.015),
                          Text(
                            controller.targetLanguage.value,
                            style: TextStyle(
                              fontSize: languageFontSize,
                              fontWeight: languageFontWeight,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.015),

              // Search Input + Button
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
                          fontSize: hintFontSize,
                          fontWeight: hintFontWeight,
                        ),
                        decoration: InputDecoration(
                          hintText: "Type in English or Marshallese",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: hintFontSize,
                            fontWeight: hintFontWeight,
                          ),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: SvgPicture.asset(
                              "assets/icons/search.svg",
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          suffixIcon: Obx(
                            () => controller.searchQuery.value.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear,
                                        color: Colors.white),
                                    onPressed: controller.clearSearch,
                                  )
                                : const SizedBox.shrink(),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  GestureDetector(
                    onTap: () {
                      controller.uploadImage();
                    },
                    child: Container(
                      width: screenWidth * 0.12,
                      height: screenWidth * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        child: SvgPicture.asset(
                          "assets/icons/app_bar.svg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: screenHeight * 0.02),

        // --- Synonym Boxes ---
        Obx(
          () => Column(
            children: controller.searchResults
                .map(
                  (result) => Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.012),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            result['synonym'] ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: hintFontSize,
                              fontWeight: hintFontWeight,
                            ),
                          ),
                          Text(
                            result['category'] ?? '',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: hintFontSize * 0.9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
