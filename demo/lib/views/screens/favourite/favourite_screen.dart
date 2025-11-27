import 'package:demo/models/lilli_models/favorites_model.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custon_bottom_navbar.dart';
import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/translation_home_controller.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final TranslationController controller = Get.find<TranslationController>();
  final BottomNavController bottomController = Get.find<BottomNavController>();
  final String? deleteIcon = "assets/icons/notification_delete.svg";

  @override
  Widget build(BuildContext context) {
    // Update selected index when this screen is displayed
    bottomController.selectedIndex.value = 1;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double getLabelFontSize() => 10.0;
    double getValueFontSize() => 14.0;
    double getCategoryFontSize() => 15.0;

    return WillPopScope(
      onWillPop: () async {
        // Update bottom nav index to Home before going back
        bottomController.selectedIndex.value = 0;
        return true; // Allow the pop
      },
      child: CommonPage(
        showAppBar: false,
        showBackButton: false,
        text: "Favorite List",
        child: Stack(
          children: [
            /// MAIN LIST CONTENT
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.09),
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
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final FavoriteModel item = favorites[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// --- English & Marshallese Group ---
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                /// --- English Column ---
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'English',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: getLabelFontSize(),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.english,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getValueFontSize(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// --- Marshallese Column ---
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Marshallese',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getLabelFontSize(),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.marshallese,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getValueFontSize(),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// --- Spacer ---
                          const Spacer(),

                          /// --- Divider ---
                          Container(
                            width: 1,
                            height: 40,
                            color: Colors.white.withOpacity(0.4),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                          ),

                          /// --- Category & Delete Group ---
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                /// --- Category Column ---
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 4),
                                      Text(
                                        item.category,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: getCategoryFontSize(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                /// --- Delete Button ---
                                GestureDetector(
                                          onTap: () {
                                            controller.removeFromFavorites(item);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.15),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/icons/notification_delete.svg",
                                              width: 20,
                                              height: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),

            /// BOTTOM NAV BAR IN STACK
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}