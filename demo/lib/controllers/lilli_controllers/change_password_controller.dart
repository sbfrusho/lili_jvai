import 'package:demo/views/screens/profile/profile_settings.dart';
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

      Future.delayed(Duration(seconds: 1),(){
        Get.to(ProfileSettingsScreen(),transition: .noTransition,duration: Duration(seconds: 0));
      });
      
    } else {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red.withOpacity(0.8), colorText: Colors.white);
    }
  }
}
