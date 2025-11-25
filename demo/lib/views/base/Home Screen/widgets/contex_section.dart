import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';

class ContextSection extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();


  ContextSection({super.key});

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
    final contextFontSize = getResponsiveFontSize(15);
    final buttonFontSize = getResponsiveFontSize(15);

    return Obx(() {
      if (!controller.showContextSection.value) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          // Context Container (SAME DESIGN AS TRANSLATION)
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with AI Badge
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Context",
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.008,
                        ),
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(

                              // translation = controller.recentTranslations[index];
                              'General',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: getResponsiveFontSize(12),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

                // Context Content Box
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: screenHeight * 0.15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Obx(
                    () {
                      final isLoading = controller.isLoadingContext.value;
                      final contextText = controller.contextResult.value;

                      if (isLoading) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Text(
                                  'Generating AI context...',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: contextFontSize,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // Loading shimmer effect
                            ...List.generate(5, (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: screenHeight * 0.008),
                                child: Container(
                                  height: 12,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }

                      return Text(
                        contextText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: contextFontSize,
                          fontWeight: FontWeight.w400,
                          height: 1.6,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.justify,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Download and Copy Buttons
          Row(
            children: [
              // Download Button
              Expanded(
                child: GestureDetector(
                  onTap: controller.downloadTranslation,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.018,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.download_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Download',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),

              // Copy Button
              Expanded(
                child: GestureDetector(
                  onTap: controller.copyTranslation,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.018,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.copy_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Copy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: buttonFontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}