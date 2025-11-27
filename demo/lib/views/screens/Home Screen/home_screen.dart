
import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/contex_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';
import 'widgets/home_header.dart';
import 'widgets/search_section.dart';
import 'widgets/translation_section.dart';
import 'widgets/recent_translation_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final bool pressed = false;

  // Find the already initialized controller
  final BottomNavController bottomController = Get.find<BottomNavController>();
  final TranslationController translationController = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    // Update the selected index when this screen is displayed
    bottomController.selectedIndex.value = 0;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.01;

    return CommonPage(
      child: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeHeader(),
                // SizedBox(height: verticalSpacing),
                SearchSection(),
                SizedBox(height: verticalSpacing),
                TranslationSection(),
                SizedBox(height: verticalSpacing),
                ContextSection(),
                SizedBox(height: verticalSpacing),
                Obx(() {
                  if (!translationController.showRecentSection.value)
                    return const SizedBox.shrink();
                  return SizedBox(
                    height: screenHeight * 0.35,
                    child: RecentTranslationWidget(),
                  );
                }),
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          ),

          // Floating Bottom NavBar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}