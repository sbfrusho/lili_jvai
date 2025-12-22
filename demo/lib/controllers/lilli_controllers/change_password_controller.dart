// import 'dart:convert';
// import 'package:demo/services/api_service.dart';
// import 'package:demo/views/screens/profile/profile_settings.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChangePasswordController extends GetxController {
//   // Text Controllers
//   final currentPasswordController = TextEditingController();
//   final newPasswordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   // Observables
//   final RxBool passwordMatch = false.obs;
//   final RxBool isLoading = false.obs;

//   final api = ApiService();

//   // Check if new password and confirm password match
//   void checkPasswordMatch() {
//     passwordMatch.value =
//         newPasswordController.text == confirmPasswordController.text &&
//         newPasswordController.text.isNotEmpty;
//   }

//   // Save password (call API)
//   Future<void> savePassword() async {
//     checkPasswordMatch();

//     if (!passwordMatch.value) {
//       Get.snackbar(
//         "Error",
//         "Passwords do not match",
//         backgroundColor: Colors.red.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//       return;
//     }

//     if (currentPasswordController.text.isEmpty ||
//         newPasswordController.text.isEmpty ||
//         confirmPasswordController.text.isEmpty) {
//       Get.snackbar(
//         "Error",
//         "Please fill all fields",
//         backgroundColor: Colors.red.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//       return;
//     }

//     isLoading.value = true;

//     try {
//       final response = await api.post(
//         "/password-change/",
//         {
//           "current_password": currentPasswordController.text,
//           "new_password": newPasswordController.text,
//           "confirm_password": confirmPasswordController.text,
//         },
//         authReq: true, // assuming this endpoint requires auth
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final resBody = json.decode(response.body);

//         Get.snackbar(
//           "Success",
//           "Password updated successfully",
//           backgroundColor: Colors.green.withOpacity(0.8),
//           colorText: Colors.white,
//         );

//         // Navigate back to Profile Settings
//         Future.delayed(const Duration(seconds: 1), () {
//           Get.to(() => ProfileSettingsScreen(),
//               transition: Transition.noTransition, duration: Duration.zero);
//         });
//       } else {
//         final resBody = json.decode(response.body);
//         final errorMessage = resBody['message'] ??
//             "Something went wrong. Please try again.";
//         Get.snackbar(
//           "Error",
//           errorMessage,
//           backgroundColor: Colors.red.withOpacity(0.8),
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Failed to change password: ${e.toString()}",
//         backgroundColor: Colors.red.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:demo/services/api_service.dart';
import 'package:demo/views/screens/profile/profile_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  // Text Controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables
  final RxBool passwordMatch = false.obs;
  final RxBool isLoading = false.obs;

  final api = ApiService();

  // Check if new password and confirm password match
  void checkPasswordMatch() {
    passwordMatch.value =
        newPasswordController.text == confirmPasswordController.text &&
        newPasswordController.text.isNotEmpty;
  }

  // Save password (call API)
  Future<bool> savePassword() async {
    checkPasswordMatch();

    if (!passwordMatch.value) return false;

    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return false;
    }

    isLoading.value = true;

    try {
      final response = await api.post(
        "/password-change/",
        {
          "current_password": currentPasswordController.text,
          "new_password": newPasswordController.text,
          "confirm_password": confirmPasswordController.text,
        },
        authReq: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Navigate to Profile Settings
        Future.delayed(const Duration(seconds: 1), () {
          if (!isClosed) {
            Get.to(
              () => ProfileSettingsScreen(),
              transition: Transition.noTransition,
              duration: Duration.zero,
            );
          }
        });
        return true;
      } else {
        // API returned error
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
