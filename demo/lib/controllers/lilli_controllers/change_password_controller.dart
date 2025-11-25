import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  // Text Controllers
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables
  final RxBool passwordMatch = false.obs;

  // Check password match
  void checkPasswordMatch() {
    passwordMatch.value =
        newPasswordController.text == confirmPasswordController.text &&
        newPasswordController.text.isNotEmpty;
  }

  // Save password
  void savePassword() {
    if (passwordMatch.value) {
      // Implement your save logic here
      Get.snackbar("Success", "Password updated successfully",
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red.withOpacity(0.8), colorText: Colors.white);
    }
  }
}
