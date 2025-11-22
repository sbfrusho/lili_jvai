import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Text Controller
  final emailController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxString emailError = ''.obs;
  final RxString enteredEmail = ''.obs; // Store email for OTP screen

  @override
  void onInit() {
    super.onInit();
    // Add listener to enable/disable button based on input
    emailController.addListener(_onEmailChanged);
  }

  @override
  void onClose() {
    // Dispose controller
    emailController.dispose();
    super.onClose();
  }

  // Listen to email changes
  void _onEmailChanged() {
    final email = emailController.text.trim();
    
    // Clear error when user starts typing
    if (emailError.value.isNotEmpty) {
      emailError.value = '';
    }
    
    // Enable button if email is not empty
    isButtonEnabled.value = email.isNotEmpty;
  }

  // Validate email
  bool _validateEmail() {
    final email = emailController.text.trim();
    
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }
    
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email address';
      return false;
    }
    
    emailError.value = '';
    return true;
  }

  // Send reset link/code
  Future<bool> sendResetLink() async {
    // Validate email first
    if (!_validateEmail()) {
      return false;
    }

    // Start loading
    isLoading.value = true;

    try {
      final email = emailController.text.trim();
      
      // Store email for OTP verification screen
      enteredEmail.value = email;

      // TODO: Implement your API call here
      // Example:
      // final response = await AuthService.sendPasswordResetCode(email);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success
      Get.snackbar(
        'Success',
        'Verification code sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      return true;

    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to send code: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
      
      return false;

    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  // Resend code (for OTP screen)
  Future<void> resendCode() async {
    isLoading.value = true;
    
    try {
      final email = enteredEmail.value.isNotEmpty 
          ? enteredEmail.value 
          : emailController.text.trim();

      // TODO: Implement resend API call
      await Future.delayed(const Duration(seconds: 2));

      Get.snackbar(
        'Success',
        'Verification code resent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend code: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate back to login
  void navigateToLogin() {
    Get.back();
  }

  // Clear email field
  void clearEmail() {
    emailController.clear();
    emailError.value = '';
    isButtonEnabled.value = false;
  }

  // Get stored email (useful for OTP screen)
  String getEmail() {
    return enteredEmail.value.isNotEmpty 
        ? enteredEmail.value 
        : emailController.text.trim();
  }
}