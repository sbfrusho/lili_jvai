import 'package:demo/controllers/bottom_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BottomNavController());

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF9A56), Color(0xFFFF7A3D)],
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
                  onTap: () => controller.changeTab(0),
                ),
                _buildNavItem(
                  icon: Icons.favorite_border,
                  label: 'Favorite',
                  index: 1,
                  isSelected: controller.selectedIndex.value == 1,
                  onTap: () => controller.changeTab(1),
                ),
                _buildNavItem(
                  icon: Icons.assignment_outlined,
                  label: 'Submission',
                  index: 2,
                  isSelected: controller.selectedIndex.value == 2,
                  onTap: () => controller.changeTab(2),
                ),
                _buildNavItem(
                  icon: Icons.smart_toy_outlined,
                  label: 'AI',
                  index: 3,
                  isSelected: controller.selectedIndex.value == 3,
                  onTap: () => controller.changeTab(3),
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              size: isSelected ? 28 : 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 13 : 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}