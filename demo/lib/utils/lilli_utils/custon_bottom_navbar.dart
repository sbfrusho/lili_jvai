
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final BottomNavController controller = Get.find<BottomNavController>();

  // SVG assets for each nav item
  final List<String> _iconAssets = [
    "assets/icons/nav_home.svg",
    "assets/icons/nav_fav.svg",
    "assets/icons/nav_sub.svg",
    "assets/icons/nav_ai.svg",
  ];

  final List<String> _labels = ["Home", "Favorite", "Submission", "AI"];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        height: screenHeight * 0.08,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 245, 124, 43),
              Color.fromARGB(255, 247, 108, 44),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_iconAssets.length, (index) {
                return _buildNavItem(
                  svgAsset: _iconAssets[index],
                  label: _labels[index],
                  index: index,
                  isSelected: controller.selectedIndex.value == index,
                  onTap: () {
                    switch (index) {
                      case 0:
                        controller.navigateToHome();
                        break;
                      case 1:
                        controller.navigateToFavorite();
                        break;
                      case 2:
                        controller.navigateToSubmissionScreen();
                        break;
                      case 3:
                        controller.navigateToAIScreen();
                        break;
                    }
                  },
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                );
              }),
            )),
      ),
    );
  }

  Widget _buildNavItem({
  required String svgAsset,
  required String label,
  required int index,
  required bool isSelected,
  required VoidCallback onTap,
  required double screenWidth,
  required double screenHeight,
}) {
  // Responsive sizes
  final iconSize = screenWidth * 0.058;

  // Safe for every device:
  final containerWidth = screenWidth * 0.22;
  final containerHeight = screenHeight * 0.065;

  // Text size (responsively scaled)
  final textSize = screenWidth * 0.028; // ~10–12 depending on screen

  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: containerWidth,
      height: containerHeight,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.015,
        vertical: screenHeight * 0.006,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.20) : Colors.transparent,
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: iconSize,
            height: iconSize,
            color: Colors.white,
          ),

          SizedBox(height: screenHeight * 0.003),

          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isSelected ? textSize * 1.05 : textSize,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
}