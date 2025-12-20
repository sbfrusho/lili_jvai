import 'dart:convert';

import 'package:demo/services/api_service.dart';
import 'package:demo/views/screens/Authentication/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Text Controller
  final emailController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxString emailError = ''.obs;
  final RxString enteredEmail = ''.obs;
  final api = ApiService();

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

      enteredEmail.value = email;
      isLoading(true);
      final response = await api.post("/password-reset/request/", {
        "email": email,
      });
      print("Forgot Password Request Response==========>>>>>>$response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        print("Forgot Password Request Response==========>>>>>>$resBody");
        
        // Check if controller is still open before navigating
        if (!isClosed) {
          Get.off(() => OtpVerificationScreen(), transition: .noTransition);
        }
        return true;
      } else {
        if (!isClosed) {
          var errorMsg = jsonDecode(response.body)['message'] ?? "Connection Error";
          Get.snackbar(
            'Error',
            errorMsg,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error, color: Colors.white),
          );
        }
        return false;
      }
    } catch (e) {
      // Handle error
      if (!isClosed) {
        Get.snackbar(
          'Error',
          'Failed to send code: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }

      return false;
    } finally {
      // Stop loading
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  // Resend code (for OTP screen)
  Future<void> resendCode() async {
    isLoading.value = true;

    try {
      final email = enteredEmail.value.isNotEmpty
          ? enteredEmail.value
          : emailController.text.trim();

      // Call API to resend code
      final response = await api.post("/password-reset/request/", {
        "email": email,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!isClosed) {
          Get.snackbar(
            'Success',
            'Verification code resent to $email',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            icon: const Icon(Icons.check_circle, color: Colors.white),
          );
        }
      } else {
        if (!isClosed) {
          Get.snackbar(
            'Error',
            'Failed to resend code',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            icon: const Icon(Icons.error, color: Colors.white),
          );
        }
      }
    } catch (e) {
      if (!isClosed) {
        Get.snackbar(
          'Error',
          'Failed to resend code: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }
    } finally {
      if (!isClosed) {
        isLoading.value = false;
      }
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
