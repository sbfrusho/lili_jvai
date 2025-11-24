import 'package:demo/views/screens/Home%20Screen/widgets/contex_section.dart';
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
            
            // Context Section - appears below Translation when AI button is clicked
            SizedBox(height: verticalSpacing),
            ContextSection(),
            
            SizedBox(height: verticalSpacing),
            
            // Recent Translation Section - Conditionally shown
            Obx(() {
              if (!controller.showRecentSection.value) {
                return const SizedBox.shrink();
              }
              
              return SizedBox(
                height: screenHeight * 0.35,
                child: RecentTranslationWidget(),
              );
            }),
          ],
        ),
      ),
    );
  }
}