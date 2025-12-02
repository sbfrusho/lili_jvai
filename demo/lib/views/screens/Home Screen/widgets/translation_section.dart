import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';
import 'package:demo/models/lilli_models/favorites_model.dart';

class TranslationSection extends StatelessWidget {
  final TranslationController controller = Get.find<TranslationController>();

  TranslationSection({super.key});

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

    final titleFontSize = getResponsiveFontSize(18);
    final resultFontSize = getResponsiveFontSize(16);

    // Convert current translation to FavoriteModel
    FavoriteModel? currentTranslation() {
      final text = controller.translationResult.value;
      if (text.isEmpty || text == 'Searching...') return null;

      return FavoriteModel(
        english: controller.sourceLanguage.value == 'English'
            ? controller.searchController.text
            : text,
        marshallese: controller.targetLanguage.value == 'Marshallese'
            ? text
            : controller.searchController.text,
        category: 'General',
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     const Color(0xFFFFCD60).withOpacity(0.2),
        //     const Color(0xFFFFFFFF).withOpacity(0.05),
        //   ],
        // ),
        color: Colors.white.withOpacity(0.12)
      ),
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              // vertical: screenHeight * 0.001,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Translation",
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Obx(() {
                  final translation = currentTranslation();
                  if (translation == null) return const SizedBox.shrink();

                  final isFav = controller.isFavorite(translation);

                  return GestureDetector(
                    onTap: () {
                      controller.toggleFavorite(translation);
                      print("Favorites button clicked!");
                    },
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: screenHeight * 0.015),

          // Translation Result Box
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: screenHeight * 0.12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Obx(() {
              final result = controller.translationResult.value;
              final isEmpty = result.isEmpty;
              final isSearching = result == 'Searching...';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSearching)
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
                          'Searching...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: resultFontSize,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    )
                  else
                    Text(
                      isEmpty ? "Translation will appear here" : result,
                      style: TextStyle(
                        color: isEmpty
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white,
                        fontSize: resultFontSize,
                        fontWeight: isEmpty ? FontWeight.w400 : FontWeight.w600,
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
