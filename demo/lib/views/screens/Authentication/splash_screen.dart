//----------------------------------------------
//Rusho
//----------------------------------------------

import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:demo/views/screens/Authentication/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).size.height * 0.10;
    return CommonPage(
      child: Column(
        children: [
          const Spacer(), // pushes content to the center vertically

          Column(
            children: [
              Image.asset("assets/icons/1.png"),
              const SizedBox(height: 32),

              Text(
                "Your Bridge to \n Marshallese",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto",
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Translate with Confidence",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: "Roboto",
                ),
              ),
            ],
          ),

          const Spacer(),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: bottomPadding),
            child: CustomButton(
              title: "Get started",
              onTap: () {
                Get.to(WelcomeScreen());
              },
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
