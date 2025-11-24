import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          "assets/icons/1.png",
          width: screenWidth * 0.15,
          height: screenHeight * 0.05,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            "assets/icons/back_button.svg",
            width: screenWidth * 0.06,
            height: screenWidth * 0.06,
          ),
        ),
      ],
    );
  }
}
