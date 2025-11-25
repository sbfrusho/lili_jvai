import 'package:demo/views/base/Home%20Screen/widgets/contex_section.dart';
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
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslationController controller = Get.put(TranslationController());
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;

    return CommonPage(
      // floatingBottomNavigationBar: const CustomBottomNavBar(),
      child: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
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
                ContextSection(),
                SizedBox(height: verticalSpacing),
                Obx(() {
                  if (!controller.showRecentSection.value) return const SizedBox.shrink();
                  return SizedBox(
                    height: screenHeight * 0.35,
                    child: RecentTranslationWidget(),
                  );
                }),
                SizedBox(height: screenHeight * 0.08), // extra bottom space so last item is visible above nav
              ],
            ),
          ),

          // Floating Bottom NavBar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const CustomBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
