import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define icon size
    final double iconSize = screenWidth * 0.09; // same for both icons

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo / left image
          Image.asset(
            "assets/icons/1.png",
            width: screenWidth * 0.15,
            height: screenHeight * 0.05,
            fit: BoxFit.contain,
          ),

          // Right icons
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: SvgPicture.asset(
                    "assets/icons/notification.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03), // spacing between icons
              GestureDetector(
                onTap: () => Get.back(),
                child: SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: SvgPicture.asset(
                    "assets/icons/profile.svg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
