// // import 'package:demo/controllers/lilli_controllers/new_password_controller.dart';
// // import 'package:demo/utils/lilli_utils/custom_text_field.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:demo/utils/lilli_utils/common_page.dart';
// // import 'package:demo/utils/lilli_utils/custom_button.dart';
// // import 'package:get/get.dart';

// // class NewPasswordScreen extends StatelessWidget {
// //   const NewPasswordScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     // Initialize controller
// //     final controller = Get.put(NewPasswordController());

// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;
// //     final verticalSpacing = screenHeight * 0.02;

// //     return CommonPage(
// //       child: Padding(
// //         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             SizedBox(height: verticalSpacing),

// //             // Top Row
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Image.asset("assets/icons/1.png", width: 64, height: 40),
// //                 GestureDetector(
// //                   onTap: () => Get.back(),
// //                   child: SvgPicture.asset(
// //                     "assets/icons/back_button.svg",
// //                     width: 24,
// //                     height: 24,
// //                   ),
// //                 ),
// //               ],
// //             ),

// //             SizedBox(height: verticalSpacing),

// //             // Title
// //             Text(
// //               "New Password",
// //               style: TextStyle(
// //                 fontSize: screenWidth * 0.07,
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.white,
// //               ),
// //             ),

// //             SizedBox(height: verticalSpacing / 2),

// //             Text(
// //               "Create a strong password for your account",
// //               style: TextStyle(
// //                 fontSize: screenWidth * 0.04,
// //                 fontWeight: FontWeight.w400,
// //                 color: Colors.white,
// //               ),
// //             ),

// //             SizedBox(height: verticalSpacing * 2),

// //             // New Password Field
// //             CustomTextField(
// //               controller: controller.newPasswordController,
// //               label: "Enter new password",
// //               prefixSvg: "assets/icons/lock.svg",
// //               height: 48,
// //               isPassword: true,
// //               radius: 24,
// //             ),

// //             // New Password Error
// //             Obx(() => controller.newPasswordError.value.isNotEmpty
// //                 ? Padding(
// //                     padding: const EdgeInsets.only(top: 4, left: 4),
// //                     child: Text(
// //                       controller.newPasswordError.value,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 12,
// //                       ),
// //                     ),
// //                   )
// //                 : const SizedBox.shrink()),

// //             // Password Strength Indicator
// //             Obx(() {
// //               final strength = controller.passwordStrength.value;
// //               final strengthText = controller.passwordStrengthText.value;
// //               final passwordText = controller.currentNewPassword.value;
              
// //               if (passwordText.isEmpty) {
// //                 return const SizedBox.shrink();
// //               }

// //               return Padding(
// //                 padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     LinearProgressIndicator(
// //                       value: strength,
// //                       backgroundColor: Colors.white,
// //                       color: Colors.white,
// //                       minHeight: 4,
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       'Password Strength: $strengthText',
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             }),

// //             const SizedBox(height: 16),

// //             // Password Requirements
// //             Obx(() {
// //               final passwordText = controller.currentNewPassword.value;
              
// //               if (passwordText.isEmpty) {
// //                 return const SizedBox.shrink();
// //               }

// //               return Container(
// //                 padding: const EdgeInsets.all(12),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.05),
// //                   borderRadius: BorderRadius.circular(12),
// //                   border: Border.all(
// //                     color: Colors.white,
// //                     width: 1,
// //                   ),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       'Password Requirements:',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 13,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 8),
// //                     ...controller.getPasswordRequirements().map((req) {
// //                       return Padding(
// //                         padding: const EdgeInsets.only(bottom: 4),
// //                         child: Row(
// //                           children: [
// //                             Icon(
// //                               req['met']
// //                                   ? Icons.check_circle
// //                                   : Icons.radio_button_unchecked,
// //                               size: 16,
// //                               color: Colors.white,
// //                             ),
// //                             const SizedBox(width: 8),
// //                             Text(
// //                               req['text'],
// //                               style: const TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 12,
// //                                 fontWeight: FontWeight.w400,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ],
// //                 ),
// //               );
// //             }),

// //             const SizedBox(height: 16),

// //             // Confirm Password Field
// //             CustomTextField(
// //               controller: controller.confirmPasswordController,
// //               label: "Confirm password",
// //               prefixSvg: "assets/icons/lock.svg",
// //               height: 48,
// //               isPassword: true,
// //               radius: 24,
// //             ),

// //             // Confirm Password Error
// //             Obx(() => controller.confirmPasswordError.value.isNotEmpty
// //                 ? Padding(
// //                     padding: const EdgeInsets.only(top: 4, left: 4),
// //                     child: Text(
// //                       controller.confirmPasswordError.value,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 12,
// //                       ),
// //                     ),
// //                   )
// //                 : const SizedBox.shrink()),

// //             const SizedBox(height: 20),

// //             // Password Match Indicator - Always visible when there's text
// //             Obx(() {
// //               final confirmText = controller.currentConfirmPassword.value;
              
// //               if (confirmText.isEmpty) {
// //                 return const SizedBox.shrink();
// //               }

// //               return Row(
// //                 children: [
// //                   Icon(
// //                     controller.passwordsMatch.value
// //                         ? Icons.check_circle
// //                         : Icons.circle_outlined,
// //                     color: Colors.white,
// //                     size: 20,
// //                   ),
// //                   const SizedBox(width: 8),
// //                   Expanded(
// //                     child: Text(
// //                       controller.passwordsMatch.value
// //                           ? "Passwords match "
// //                           : "Passwords match",
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             }),

// //             SizedBox(height: verticalSpacing * 3),

// //             const Spacer(),


// //             // Continue Button with Loading State
// //             Obx(() {
// //               if (controller.isLoading.value) {
// //                 return const Center(
// //                   child: CircularProgressIndicator(
// //                     color: Colors.white,
// //                   ),
// //                 );
// //               }

// //               return CustomButton(
// //                 title: "Set New Password",
// //                 height: 53,
// //                 width: screenWidth,
// //                 backgroundOpacity: 0.2,
// //                 backgroundColor: controller.passwordsMatch.value
// //                     ? const Color(0xFFFFffff).withOpacity(0.2)
// //                     : Colors.white.withOpacity(0.2),
// //                 onTap: controller.passwordsMatch.value
// //                     ? controller.updatePassword
// //                     : null,
// //               );
// //             }),

// //             SizedBox(height: verticalSpacing * 2),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:demo/controllers/lilli_controllers/new_password_controller.dart';
// import 'package:demo/utils/lilli_utils/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:demo/utils/lilli_utils/common_page.dart';
// import 'package:demo/utils/lilli_utils/custom_button.dart';
// import 'package:get/get.dart';

// class NewPasswordScreen extends StatefulWidget {
//   const NewPasswordScreen({super.key});

//   @override
//   State<NewPasswordScreen> createState() => _NewPasswordScreenState();
// }

// class _NewPasswordScreenState extends State<NewPasswordScreen> {
//   final FocusNode newPasswordFocus = FocusNode();
//   final FocusNode confirmPasswordFocus = FocusNode();
//   bool isConfirmPasswordFocused = false;

//   @override
//   void initState() {
//     super.initState();
    
//     // Listen to confirm password focus changes
//     confirmPasswordFocus.addListener(() {
//       setState(() {
//         isConfirmPasswordFocused = confirmPasswordFocus.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     newPasswordFocus.dispose();
//     confirmPasswordFocus.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Initialize controller
//     final controller = Get.put(NewPasswordController());

//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final verticalSpacing = screenHeight * 0.02;

//     return CommonPage(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: verticalSpacing),

//             // Top Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Image.asset("assets/icons/1.png", width: 64, height: 40),
//                 GestureDetector(
//                   onTap: () => Get.back(),
//                   child: SvgPicture.asset(
//                     "assets/icons/back_button.svg",
//                     width: 24,
//                     height: 24,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: verticalSpacing),

//             // Title
//             Text(
//               "New Password",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.07,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//               ),
//             ),

//             SizedBox(height: verticalSpacing / 2),

//             Text(
//               "Create a strong password for your account",
//               style: TextStyle(
//                 fontSize: screenWidth * 0.04,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//               ),
//             ),

//             SizedBox(height: verticalSpacing * 2),

//             // New Password Field
//             CustomTextField(
//               controller: controller.newPasswordController,
//               label: "Enter new password",
//               prefixSvg: "assets/icons/lock.svg",
//               height: 48,
//               isPassword: true,
//               radius: 24,
//               focusNode: newPasswordFocus,
//             ),

//             // New Password Error
//             Obx(() => controller.newPasswordError.value.isNotEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 4, left: 4),
//                     child: Text(
//                       controller.newPasswordError.value,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink()),

//             // Password Strength Indicator
//             Obx(() {
//               final strength = controller.passwordStrength.value;
//               final strengthText = controller.passwordStrengthText.value;
//               final passwordText = controller.currentNewPassword.value;
              
//               if (passwordText.isEmpty) {
//                 return const SizedBox.shrink();
//               }

//               return Padding(
//                 padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     LinearProgressIndicator(
//                       value: strength,
//                       backgroundColor: Colors.white,
//                       color: Colors.white,
//                       minHeight: 4,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Password Strength: $strengthText',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }),

//             const SizedBox(height: 12),

//             // Password Requirements - Hide when confirm password is focused
//             Obx(() {
//               final passwordText = controller.currentNewPassword.value;
              
//               if (passwordText.isEmpty || isConfirmPasswordFocused) {
//                 return const SizedBox.shrink();
//               }

//               return Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: Colors.white,
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Password Requirements:',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ...controller.getPasswordRequirements().map((req) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 4),
//                         child: Row(
//                           children: [
//                             Icon(
//                               req['met']
//                                   ? Icons.check_circle
//                                   : Icons.radio_button_unchecked,
//                               size: 16,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               req['text'],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               );
//             }),

//             const SizedBox(height: 12),

//             // Confirm Password Field
//             CustomTextField(
//               controller: controller.confirmPasswordController,
//               label: "Confirm password",
//               prefixSvg: "assets/icons/lock.svg",
//               height: 48,
//               isPassword: true,
//               radius: 24,
//               focusNode: confirmPasswordFocus,
//             ),

//             // Confirm Password Error
//             Obx(() => controller.confirmPasswordError.value.isNotEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 4, left: 4),
//                     child: Text(
//                       controller.confirmPasswordError.value,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink()),

//             const SizedBox(height: 12),

//             // Password Match Indicator - Always visible when there's text
//             Obx(() {
//               final confirmText = controller.currentConfirmPassword.value;
              
//               if (confirmText.isEmpty) {
//                 return const SizedBox.shrink();
//               }

//               return Row(
//                 children: [
//                   Icon(
//                     controller.passwordsMatch.value
//                         ? Icons.check_circle
//                         : Icons.circle_outlined,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       controller.passwordsMatch.value
//                           ? "Passwords match "
//                           : "Passwords match",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),

//             SizedBox(height: verticalSpacing * 3),

//             const Spacer(),

//             // Continue Button with Loading State
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 );
//               }

//               return CustomButton(
//                 title: "Set New Password",
//                 height: 53,
//                 width: screenWidth,
//                 backgroundOpacity: 0.2,
//                 backgroundColor: controller.passwordsMatch.value
//                     ? const Color(0xFFFFffff).withOpacity(0.2)
//                     : Colors.white.withOpacity(0.2),
//                 onTap: controller.passwordsMatch.value
//                     ? controller.updatePassword
//                     : null,
//               );
//             }),

//             SizedBox(height: verticalSpacing * 2),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:demo/controllers/lilli_controllers/new_password_controller.dart';
import 'package:demo/utils/lilli_utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo/utils/lilli_utils/common_page.dart';
import 'package:demo/utils/lilli_utils/custom_button.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  bool isConfirmPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    
    // Listen to confirm password focus changes
    confirmPasswordFocus.addListener(() {
      setState(() {
        isConfirmPasswordFocused = confirmPasswordFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    newPasswordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(NewPasswordController());

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final verticalSpacing = screenHeight * 0.02;

    return CommonPage(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: verticalSpacing),

            // Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icons/1.png", width: 64, height: 40),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    "assets/icons/back_button.svg",
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),

            SizedBox(height: verticalSpacing),

            // Title
            Text(
              "New Password",
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            SizedBox(height: verticalSpacing / 2),

            Text(
              "Create a strong password for your account",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),

            SizedBox(height: verticalSpacing * 2),

            // New Password Field
            CustomTextField(
              controller: controller.newPasswordController,
              label: "Enter new password",
              prefixSvg: "assets/icons/lock.svg",
              height: 48,
              isPassword: true,
              radius: 24,
              focusNode: newPasswordFocus,
            ),

            // New Password Error
            Obx(() => controller.newPasswordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.newPasswordError.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),

            // Password Strength Indicator
            Obx(() {
              final strength = controller.passwordStrength.value;
              final strengthText = controller.passwordStrengthText.value;
              final passwordText = controller.currentNewPassword.value;
              
              if (passwordText.isEmpty) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 8, left: 4, right: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: strength,
                      backgroundColor: Colors.white,
                      color: Colors.white,
                      minHeight: 4,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Password Strength: $strengthText',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),

            // Password Requirements - Hide when confirm password is focused
            Obx(() {
              final passwordText = controller.currentNewPassword.value;
              
              if (passwordText.isEmpty || isConfirmPasswordFocused) {
                return const SizedBox.shrink();
              }

              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password Requirements:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...controller.getPasswordRequirements().map((req) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              req['met']
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              req['text'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            }),

            const SizedBox(height: 12),

            // Confirm Password Field
            CustomTextField(
              controller: controller.confirmPasswordController,
              label: "Confirm password",
              prefixSvg: "assets/icons/lock.svg",
              height: 48,
              isPassword: true,
              radius: 24,
              focusNode: confirmPasswordFocus,
            ),

            // Confirm Password Error
            Obx(() => controller.confirmPasswordError.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, left: 4),
                    child: Text(
                      controller.confirmPasswordError.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                : const SizedBox.shrink()),

            const SizedBox(height: 12),

            // Password Match Indicator - Always visible when there's text
            Obx(() {
              final confirmText = controller.currentConfirmPassword.value;
              
              if (confirmText.isEmpty) {
                return const SizedBox.shrink();
              }

              return Row(
                children: [
                  Icon(
                    controller.passwordsMatch.value
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      controller.passwordsMatch.value
                          ? "Passwords match "
                          : "Passwords match",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            }),

            SizedBox(height: verticalSpacing * 3),

            const Spacer(),

            // Continue Button with Loading State
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }

              return CustomButton(
                title: "Set New Password",
                height: 53,
                width: screenWidth,
                backgroundOpacity: 0.2,
                backgroundColor: controller.passwordsMatch.value
                    ? const Color(0xFFFFffff).withOpacity(0.2)
                    : Colors.white.withOpacity(0.2),
                onTap: controller.passwordsMatch.value
                    ? controller.updatePassword
                    : null,
              );
            }),

            SizedBox(height: verticalSpacing * 2),
          ],
        ),
      ),
    );
  }
}