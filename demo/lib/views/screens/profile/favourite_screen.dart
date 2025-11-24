import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:demo/controllers/translation_home_controller.dart';

class FavoritesPage extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double getResponsiveFontSize(double baseSize) {
      if (screenWidth < 360) return baseSize * 0.85;
      if (screenWidth < 400) return baseSize * 0.9;
      if (screenWidth > 600) return baseSize * 1.1;
      return baseSize;
    }

    final titleFontSize = getResponsiveFontSize(20);
    final labelFontSize = getResponsiveFontSize(11);
    final textFontSize = getResponsiveFontSize(15);
    final categoryFontSize = getResponsiveFontSize(12);

    final today = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.folder, color: Colors.white, size: 24),
            SizedBox(width: screenWidth * 0.02),
            Text(
              today,
              style: TextStyle(
                color: Colors.white,
                fontSize: titleFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.favoriteTranslations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star_border, size: 48, color: Colors.white.withOpacity(0.3)),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'No favorites yet',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: textFontSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Tap the star icon to add translations to favorites',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: labelFontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
          itemCount: controller.favoriteTranslations.length,
          itemBuilder: (context, index) {
            final translation = controller.favoriteTranslations[index];

            return Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.012),
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
                              _buildLabel('English', labelFontSize, screenWidth, screenHeight),
                              SizedBox(width: screenWidth * 0.03),
                              _buildLabel('Marshallese', labelFontSize, screenWidth, screenHeight),
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

                    // Category badge and Delete button
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
                        // Delete button
                        GestureDetector(
                          onTap: () => controller.removeFromFavorites(translation),
                          child: Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildLabel(String text, double fontSize, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.004,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
