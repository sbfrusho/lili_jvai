// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  // Text Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString profileImagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load existing user data
    _loadUserData();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  // Load user data (from local storage or API)
  void _loadUserData() {
    fullNameController.text = "";
    emailController.text = "";
    phoneController.text = "";
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      // Example:
      // final ImagePicker picker = ImagePicker();
      // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // if (image != null) {
      //   profileImagePath.value = image.path;
      // }

      Get.snackbar(
        'Image Upload',
        'Image picker will be implemented here',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Validate form
  bool _validateForm() {
    if (fullNameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your full name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Validation Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter your phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Save profile
  Future<void> saveProfile() async {
    if (!_validateForm()) {
      return;
    }

    isLoading.value = true;

    try {
      final name = fullNameController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();
      // Example:
      // await UserService.updateProfile(
      //   name: name,
      //   email: email,
      //   phone: phone,
      //   imagePath: profileImagePath.value,
      // );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Success
      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // Navigate back
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Cancel editing
  void cancelEdit() {
    Get.back();
  }
}