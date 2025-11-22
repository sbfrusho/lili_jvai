import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/common_page.dart';
import 'package:demo/utils/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool agreeTerms = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.05;
    final verticalSpacing = screenHeight * 0.02;

    OutlineInputBorder borderStyle(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 0.5, color: color),
        );

    return CommonPage(
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalSpacing,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.08),

                // Header
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: verticalSpacing / 2),
                    Text(
                      "Join us to bridge language barriers",
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing * 2),

                // Full Name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: const Icon(Icons.person),
                    enabledBorder: borderStyle(Colors.grey),
                    focusedBorder: borderStyle(Colors.blue),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(height: verticalSpacing),

                // Email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/email.svg",
                      width: 24,
                      height: 24,
                    ),
                    enabledBorder: borderStyle(Colors.grey),
                    focusedBorder: borderStyle(Colors.blue),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(height: verticalSpacing),

                // Password
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Password (8+ characters)",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    enabledBorder: borderStyle(Colors.grey),
                    focusedBorder: borderStyle(Colors.blue),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),
                SizedBox(height: verticalSpacing),

                // Confirm Password
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirm,
                  decoration: InputDecoration(
                    labelText: "Re-enter Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirm = !obscureConfirm;
                        });
                      },
                    ),
                    enabledBorder: borderStyle(Colors.grey),
                    focusedBorder: borderStyle(Colors.blue),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  ),
                ),

                SizedBox(height: verticalSpacing),

                // Terms
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: agreeTerms,
                      onChanged: (val) {
                        setState(() {
                          agreeTerms = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "You agree to the Terms of Service and acknowledge you have read the Privacy Policy.",
                        style: TextStyle(fontSize: screenWidth * 0.035),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing),

                // Sign Up Button
                CustomButton(
                  title: "Sign Up",
                  onTap: () {
                    if (!agreeTerms) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please agree to the terms")),
                      );
                      return;
                    }
                  },
                  width: screenWidth,
                  padding: EdgeInsets.symmetric(vertical: verticalSpacing * 1.2),
                ),

                SizedBox(height: verticalSpacing / 2),

                // Already have an account
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Already have an account? Log in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),

                SizedBox(height: verticalSpacing * 2),

                // Divider
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Or Sign Up With"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                SizedBox(height: verticalSpacing),

                // Social Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Google",
                        onTap: () {},
                        prefixImageAsset: "assets/icons/google_icon.svg",
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                      ),
                    ),
                    SizedBox(width: horizontalPadding / 2),
                    Expanded(
                      child: CustomButton(
                        title: "Apple",
                        onTap: () {},
                        prefixImageAsset: "assets/icons/apple_icon.svg",
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(vertical: verticalSpacing),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalSpacing * 3),
              ],
            ),
          ),

          // Top Left Logo
          Positioned(
            top: verticalSpacing,
            left: horizontalPadding,
            child: Image.asset(
              "assets/icons/1.png",
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
            ),
          ),

          // Top Right Back Button
          Positioned(
            top: verticalSpacing,
            right: horizontalPadding,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/icons/back_button.svg",
                width: screenWidth * 0.06,
                height: screenWidth * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
