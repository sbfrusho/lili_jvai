import 'package:demo/models/lilli_models/favorites_model.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final TranslationController controller = Get.find<TranslationController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive font sizes
    double getLabelFontSize() => screenWidth * 0.043; // ~11
    double getValueFontSize() => screenWidth * 0.035; // ~18
    double getCategoryFontSize() => screenWidth * 0.035; // ~13

    // Responsive gaps
    double horizontalGap() => screenWidth * 0.04; // Gap between English & Marshallese
    double categoryGap() => screenWidth * 0.03; // Gap between Marshallese & Category

    // Responsive padding
    double containerPadding() => screenWidth * 0.04; // ~16

    return CommonPage(
      showAppBar: true,
      text: "Favorite List",
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              final favorites = controller.favoriteTranslations;

              if (favorites.isEmpty) {
                return const Center(
                  child: Text(
                    "No favorites yet",
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: containerPadding(),
                  vertical: screenHeight * 0.01,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final FavoriteModel item = favorites[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                    padding: EdgeInsets.all(containerPadding()),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left section: English & Marshallese
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Labels row
                              Row(
                                children: [
                                  Text(
                                    'English',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getLabelFontSize(),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: horizontalGap()),
                                  Text(
                                    'Marshallese',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getLabelFontSize(),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              // Values row
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      item.english,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: getValueFontSize(),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: horizontalGap()),
                                  Flexible(
                                    child: Text(
                                      item.marshallese,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: getValueFontSize(),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: categoryGap()),

                        // Category badge
                        Text(
                          item.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getCategoryFontSize(),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(width: screenWidth * 0.03),

                        // Delete button
                        GestureDetector(
                          onTap: () {
                            controller.removeFromFavorites(item);
                            Get.snackbar(
                              'Removed',
                              '${item.english} removed from favorites',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red.withOpacity(0.8),
                              colorText: Colors.white,
                              duration: const Duration(seconds: 2),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: screenWidth * 0.05, // responsive icon size
                            ),
                          ),
                        ),
                      ],
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
