// import 'package:demo/controllers/translation_home_controller.dart';
// import 'package:demo/views/screens/Home%20Screen/widgets/recent_translation_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:demo/utils/common_page.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final TranslationController controller = Get.put(TranslationController());

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     // Responsive paddings
//     final horizontalPadding = screenWidth * 0.05;
//     final verticalSpacing = screenHeight * 0.02;

//     // Responsive font sizes and weights
//     double getFontSize(double small, double large) =>
//         screenWidth < 400 ? small : large;
//     FontWeight getFontWeight(double small, double large) =>
//         screenWidth < 400 ? FontWeight.w400 : FontWeight.w600;

//     final titleFontSize = getFontSize(20, 32);
//     final titleFontWeight = getFontWeight(400, 600);

//     final languageFontSize = getFontSize(16, 20);
//     final languageFontWeight = getFontWeight(400, 600);

//     final hintFontSize = getFontSize(14, 18);
//     final hintFontWeight = getFontWeight(400, 400);

//     return CommonPage(
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//           horizontal: horizontalPadding,
//           vertical: verticalSpacing,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Logo and Back Button Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset(
//                   "assets/icons/1.png",
//                   width: screenWidth * 0.15,
//                   height: screenHeight * 0.05,
//                 ),
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: SvgPicture.asset(
//                     "assets/icons/back_button.svg",
//                     width: screenWidth * 0.06,
//                     height: screenWidth * 0.06,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: verticalSpacing),

//             // Outer container for Search + Translation
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                 color: Colors.white.withOpacity(0.08),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(screenWidth * 0.05),
//                 child: Column(
//                   children: [
//                     // --- Search Section ---
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFFFFCD60).withOpacity(.5),
//                             Color(0xFFFFFFFF).withOpacity(.05),
//                           ],
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           // Label + Language Switch
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.04,
//                               vertical: screenHeight * 0.015,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Search",
//                                   style: TextStyle(
//                                     fontSize: titleFontSize,
//                                     fontWeight: titleFontWeight,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 Obx(
//                                   () => GestureDetector(
//                                     onTap: controller.swapLanguages,
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           controller.sourceLanguage.value,
//                                           style: TextStyle(
//                                             fontSize: languageFontSize,
//                                             fontWeight: languageFontWeight,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         SizedBox(width: screenWidth * 0.015),
//                                         SvgPicture.asset(
//                                           "assets/icons/swap.svg",
//                                           color: Colors.white,
//                                           width: screenWidth * 0.04,
//                                           height: screenWidth * 0.04,
//                                         ),
//                                         SizedBox(width: screenWidth * 0.015),
//                                         Text(
//                                           controller.targetLanguage.value,
//                                           style: TextStyle(
//                                             fontSize: languageFontSize,
//                                             fontWeight: languageFontWeight,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           SizedBox(height: screenHeight * 0.015),

//                           // Search Input + Custom Button
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: screenWidth * 0.04,
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(
//                                         screenWidth * 0.03,
//                                       ),
//                                     ),
//                                     child: TextField(
//                                       controller: controller.searchController,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: hintFontSize,
//                                         fontWeight: hintFontWeight,
//                                       ),
//                                       decoration: InputDecoration(
//                                         hintText:
//                                             "Type in English or Marshallese",
//                                         hintStyle: TextStyle(
//                                           color: Colors.white.withOpacity(0.7),
//                                           fontSize: hintFontSize,
//                                           fontWeight: hintFontWeight,
//                                         ),
//                                         prefixIcon: Padding(
//                                           padding: EdgeInsets.all(
//                                             screenWidth * 0.02,
//                                           ),
//                                           child: SvgPicture.asset(
//                                             "assets/icons/search.svg",
//                                             color: Colors.white.withOpacity(
//                                               0.8,
//                                             ),
//                                             width: screenWidth * 0.05,
//                                             height: screenWidth * 0.05,
//                                           ),
//                                         ),
//                                         suffixIcon: Obx(
//                                           () =>
//                                               controller
//                                                   .searchQuery
//                                                   .value
//                                                   .isNotEmpty
//                                               ? IconButton(
//                                                   icon: Icon(
//                                                     Icons.clear,
//                                                     color: Colors.white,
//                                                     size: screenWidth * 0.045,
//                                                   ),
//                                                   onPressed:
//                                                       controller.clearSearch,
//                                                 )
//                                               : SizedBox.shrink(),
//                                         ),
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.symmetric(
//                                           horizontal: screenWidth * 0.04,
//                                           vertical: screenHeight * 0.015,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: screenWidth * 0.02),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Get.snackbar(
//                                       'Button Pressed',
//                                       'Custom image button clicked',
//                                       snackPosition: SnackPosition.BOTTOM,
//                                       backgroundColor: Colors.blue,
//                                       colorText: Colors.white,
//                                     );
//                                   },
//                                   child: Container(
//                                     width: screenWidth * 0.12,
//                                     height: screenWidth * 0.12,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(
//                                         screenWidth * 0.03,
//                                       ),
//                                       color: Colors.white.withOpacity(0.2),
//                                     ),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(
//                                         screenWidth * 0.03,
//                                       ),
//                                       child: SvgPicture.asset(
//                                         "assets/icons/app_bar.svg",
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     SizedBox(height: screenHeight * 0.025),

//                     // --- Translation Section inside same container ---
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                         gradient: LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color(0xFFFFCD60).withOpacity(.5),
//                             Color(0xFFFFFFFF).withOpacity(.05),
//                           ],
//                         ),
//                       ),
//                       padding: EdgeInsets.all(screenWidth * 0.04),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Translation",
//                             style: TextStyle(
//                               fontSize: titleFontSize,
//                               fontWeight: titleFontWeight,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.015),
//                           Container(
//                             width: double.infinity,
//                             height: screenHeight * 0.12,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.08),
//                               borderRadius: BorderRadius.circular(
//                                 screenWidth * 0.03,
//                               ),
//                             ),
//                             padding: EdgeInsets.all(
//                               screenWidth * 0.03,
//                             ), // optional padding
//                             child: Obx(
//                               () => Text(
//                                 controller.translationResult.value.isEmpty
//                                     ? "Searching"
//                                     : controller.translationResult.value,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: hintFontSize,
//                                   fontWeight: hintFontWeight,
//                                 ),
//                                 textAlign:
//                                     TextAlign.left, // text aligned to left
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // After your Translation container
//             SizedBox(height: screenHeight * 0.02),

//             // Recent Translation Section
//             SizedBox(
//               height: screenHeight * 0.35, // or whatever height you want
//               child: RecentTranslationWidget(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/utils/common_page.dart';
import 'package:demo/controllers/translation_home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/search_section.dart';
import 'widgets/translation_section.dart';
import 'widgets/recent_translation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslationController controller = Get.put(TranslationController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;

    return CommonPage(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(),
            SizedBox(height: verticalSpacing),
            SearchSection(),
            SizedBox(height: verticalSpacing),
            TranslationSection(),
            SizedBox(height: verticalSpacing),
            SizedBox(
              height: screenHeight * 0.35,
              child: RecentTranslationWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
