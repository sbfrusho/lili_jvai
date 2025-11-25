import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';

class RecentTranslationWidget extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  RecentTranslationWidget({super.key});

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

    final titleFontSize = getResponsiveFontSize(20);
    final labelFontSize = getResponsiveFontSize(11);
    final textFontSize = getResponsiveFontSize(15);
    final categoryFontSize = getResponsiveFontSize(12);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Icon(
                  Icons.history_rounded,
                  color: Colors.white,
                  size: getResponsiveFontSize(22),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Recent Translations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // List of Recent Translations
          Expanded(
            child: Obx(() {
              if (controller.recentTranslations.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.translate_rounded,
                          size: 48,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'No recent translations',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: textFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Start translating to see your history',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: labelFontSize,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01,
                ),
                itemCount: controller.recentTranslations.length,
                itemBuilder: (context, index) {
                  final translation = controller.recentTranslations[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.012),
                    child: GestureDetector(
                      onTap: () => controller.openTranslationDetail(translation),
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.035),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Translation content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Language labels
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02,
                                          vertical: screenHeight * 0.004,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'English',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: labelFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.03),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.02,
                                          vertical: screenHeight * 0.004,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          'Marshallese',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: labelFontSize,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.008),
                                  
                                  // Translation values
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          translation['english'] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: textFontSize,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: screenWidth * 0.04),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          translation['marshallese'] ?? '',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: textFontSize,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(width: screenWidth * 0.02),
                            
                            // Category badge and arrow
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.025,
                                    vertical: screenHeight * 0.006,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFCD60).withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    translation['category'] ?? 'General',
                                    style: TextStyle(
                                      fontSize: categoryFontSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.008),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

/*
  English Marshallese       
                              |General   delete_button
  Hello    yokew
 */