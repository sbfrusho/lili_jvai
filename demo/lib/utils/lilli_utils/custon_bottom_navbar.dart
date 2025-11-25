import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/controllers/lilli_controllers/bottom_navigation_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
   CustomBottomNavBar({super.key});
  final controller = Get.put(BottomNavController());


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: Container(
        height: 70, // Increased height of navbar
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 245, 124, 43),
              Color.fromARGB(255, 247, 108, 44)
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
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  index: 0,
                  isSelected: controller.selectedIndex.value == 0,
                  onTap: () => controller.navigateToHome(),
                ),
                _buildNavItem(
                  icon: Icons.favorite_border,
                  label: 'Favorite',
                  index: 1,
                  isSelected: controller.selectedIndex.value == 1,
                  onTap: () => controller.navigateToFavorite(),
                ),
                _buildNavItem(
                  icon: Icons.assignment_outlined,
                  label: 'Submission',
                  index: 2,
                  isSelected: controller.selectedIndex.value == 2,
                  onTap: () => controller.navigateToSubmissionScreen(),
                ),
                _buildNavItem(
                  icon: Icons.smart_toy_outlined,
                  label: 'AI',
                  index: 3,
                  isSelected: controller.selectedIndex.value == 3,
                  onTap: () => controller.navigateToAIScreen(),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // Smaller box when selected
    final padding = isSelected
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    final iconSize = isSelected ? 26.0 : 24.0;
    final fontSize = isSelected ? 13.0 : 11.0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: iconSize,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
