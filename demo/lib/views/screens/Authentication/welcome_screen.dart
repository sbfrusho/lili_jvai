import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:demo/views/screens/Authentication/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/common_page.dart';
import 'package:demo/utils/custom_button.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).size.height * 0.10;
    final screenWidth = MediaQuery.of(context).size.width;

    return CommonPage(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Column(
                children: [
                  Image.asset("assets/icons/1.png"),
                  const SizedBox(height: 32),

                  const Text(
                    "Welcome to\nH&L Linguistic Services",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Roboto",
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Your bilingual companion for fast, accurate English - Marshallese translations — from daily conversations to medical terms",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: "Roboto",
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: bottomPadding,
                ),
                child: Column(
                  children: [
                    CustomButton(
                      title: "Sign Up",
                      width: screenWidth,
                      onTap: () {
                        Get.to(() => const SignUpScreen());
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      title: "Login",
                      width: screenWidth,
                      onTap: () {
                        Get.to(() => LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Back button (optional if this is first screen)
          Positioned(
            top: 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(
                "assets/icons/back_button.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
