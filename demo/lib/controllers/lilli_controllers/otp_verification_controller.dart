// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:demo/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  // OTP Controllers for 6 digits
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxString otpError = ''.obs;
  final RxInt resendTimer = 60.obs;
  final RxBool canResend = false.obs;
  final RxString maskedEmail = ''.obs;
  final api = ApiService();

  Timer? _timer;
  String? email;

  @override
  void onInit() {
    super.onInit();

    // Initialize controllers and focus nodes
    otpControllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());

    // Add listeners to all OTP fields
    for (int i = 0; i < 6; i++) {
      otpControllers[i].addListener(() => _onOtpChanged(i));
    }

    // Start resend timer
    startResendTimer();

    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void onClose() {
    // Dispose all controllers and focus nodes
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  // Handle OTP input changes
  void _onOtpChanged(int index) {
    final text = otpControllers[index].text;

    // Clear error when user types
    if (otpError.value.isNotEmpty) {
      otpError.value = '';
    }

    // Move to next field if current field has value
    if (text.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    // Check if all fields are filled
    _checkOtpComplete();
  }

  // Handle backspace
  void onBackspace(int index) {
    if (otpControllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  // Check if OTP is complete
  void _checkOtpComplete() {
    bool allFilled = otpControllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    isButtonEnabled.value = allFilled;
  }

  // Get complete OTP code
  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

  // Validate OTP
  bool _validateOtp() {
    final otp = getOtpCode();

    if (otp.length != 6) {
      otpError.value = 'Please enter complete 6-digit code';
      return false;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      otpError.value = 'OTP must contain only numbers';
      return false;
    }

    otpError.value = '';
    return true;
  }

  // Verify OTP
  Future<bool> verifyOtp() async {
    // Check if email is set
    if (email == null || email!.isEmpty) {
      otpError.value = 'Email not found. Please try again.';
      Get.snackbar(
        'Error',
        'Email not found. Please go back and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return false;
    }

    // Validate OTP first
    if (!_validateOtp()) {
      return false;
    }

    // Start loading
    isLoading.value = true;

    try {
      final otp = getOtpCode();

      print("Email being sent: $email");
      print("OTP being sent: $otp");

      final response = await api.post("/reset/otp-verify/", {
        "email": email,
        "otp": otp,
      });
      
      print("OTP Verify Request Response==========>>>>>>$response");
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        print("OTP Verify Response Body==========>>>>>>$resBody");

        await Future.delayed(const Duration(seconds: 1));

        // Success message
        if (!isClosed) {
          Get.snackbar(
            'Success',
            'OTP verified successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            icon: const Icon(Icons.check_circle, color: Colors.white),
          );
        }
        return true;
      } else {
        // Handle error response
        var errorBody = jsonDecode(response.body);
        String errorMsg = errorBody['message'] ?? "Verification failed";
        
        // Check for specific error in details
        if (errorBody['details'] != null && errorBody['details']['email'] != null) {
          errorMsg = errorBody['details']['email'][0];
        }
        
        otpError.value = errorMsg;
        
        if (!isClosed) {
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
      otpError.value = 'Invalid OTP code. Please try again.';

      if (!isClosed) {
        Get.snackbar(
          'Error',
          'OTP verification failed: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }

      // Clear OTP fields on error
      clearOtp();

      return false;
    } finally {
      // Stop loading
      if (!isClosed) {
        isLoading.value = false;
      }
    }
  }

  // Start resend timer
  void startResendTimer() {
    canResend.value = false;
    resendTimer.value = 60;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  // Resend OTP
  Future<void> resendOtp() async {
    if (!canResend.value) return;
    if (email == null || email!.isEmpty) {
      Get.snackbar(
        'Error',
        'Email not set. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
      return;
    }

    isLoading.value = true;

    try {
      // Call API to resend OTP
      final response = await api.post("/otp/create/", {"email": email});

      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        print("Resend OTP Response==========>>>>>>$resBody");

        // Clear existing OTP
        clearOtp();

        // Restart timer
        startResendTimer();

        if (!isClosed) {
          Get.snackbar(
            'Success',
            'OTP code resent successfully!',
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
            'Failed to resend OTP',
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
          'Failed to resend OTP: ${e.toString()}',
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

  // Clear all OTP fields
  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
    isButtonEnabled.value = false;
    otpError.value = '';
  }

  // Set email from previous screen
  void setEmail(String userEmail) {
    email = userEmail;
    print("Email set in controller: $email");
  }

  // Get masked email for display (e.g., "j***@gmail.com")
  String getMaskedEmail() {
    if (email == null || email!.isEmpty) return '';

    final parts = email!.split('@');
    if (parts.length != 2) return email!;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }

    return '${username[0]}${'*' * (username.length - 2)}${username[username.length - 1]}@$domain';
  }

  // Paste OTP from clipboard
  void pasteOtp(String text) {
    // Extract only digits
    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) return;

    // Fill OTP fields
    for (int i = 0; i < 6 && i < digits.length; i++) {
      otpControllers[i].text = digits[i];
    }

    // Focus last filled field
    final lastIndex = digits.length > 6 ? 5 : digits.length - 1;
    if (lastIndex >= 0 && lastIndex < 6) {
      focusNodes[lastIndex].requestFocus();
    }
  }
}