

import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/contex_section.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/home_header.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/recent_translation_widget.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/search_section.dart';
import 'package:demo/views/screens/Home%20Screen/widgets/translation_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Controllers
  final BottomNavController bottomController = Get.find<BottomNavController>();
  final TranslationController translationController = Get.put(TranslationController());

  @override
  Widget build(BuildContext context) {
    // Ensure bottom nav index is set
    bottomController.selectedIndex.value = 0;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;

    return CommonPage(
      child: Stack(
        children: [
          // ---------------- MAIN SCROLLABLE CONTENT ----------------
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalSpacing,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                HomeHeader(),

                SizedBox(height: verticalSpacing),

                // Search + Translation Section container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SearchSection(),
                      SizedBox(height: verticalSpacing),
                      TranslationSection(),
                    ],
                  ),
                ),

                SizedBox(height: verticalSpacing),

                // AI Context Section
                ContextSection(),

                // Single Download & Copy Buttons - After Context Section
                Obx(() {
                  if (!translationController.showTranslationSection.value) {
                    return const SizedBox.shrink();
                  }
                  
                  return Padding(
                    padding: EdgeInsets.only(top: verticalSpacing),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: 'Download',
                            onTap: translationController.downloadTranslation,
                            backgroundColor: Colors.white,
                            backgroundOpacity: 0.2,
                            borderRadius: 12,
                            height: 50,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            title: 'Copy',
                            onTap: translationController.copyTranslation,
                            backgroundColor: Colors.white,
                            backgroundOpacity: 0.2,
                            borderRadius: 12,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(height: verticalSpacing),

                // ---------------- RECENT TRANSLATIONS ----------------
                Obx(() {
                  if (!translationController.showRecentSection.value) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    height: screenHeight * 0.35,
                    child: RecentTranslationWidget(),
                  );
                }),

                // Extra space at bottom so content doesn't hide behind nav
                SizedBox(height: screenHeight * 0.08),
              ],
            ),
          ),

          // ---------------- FLOATING BOTTOM NAVBAR ----------------
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