import 'dart:async';
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
  final RxString maskedEmail = ''.obs; // Observable masked email
  
  Timer? _timer;
  String? email; // Email from previous screen

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
    bool allFilled = otpControllers.every((controller) => controller.text.isNotEmpty);
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
    // Validate OTP first
    if (!_validateOtp()) {
      return false;
    }

    // Start loading
    isLoading.value = true;

    try {
      final otp = getOtpCode();
      
      // TODO: Implement your API call here
      // Example:
      // final response = await AuthService.verifyOtp(email, otp);
      
      // Temporary: Remove this delay when implementing API
      await Future.delayed(const Duration(seconds: 1));

      // Success message
      Get.snackbar(
        'Success',
        'OTP verified successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      return true;

    } catch (e) {
      // Handle error
      otpError.value = 'Invalid OTP code. Please try again.';
      
      Get.snackbar(
        'Error',
        'OTP verification failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
      
      // Clear OTP fields on error
      clearOtp();
      
      return false;

    } finally {
      // Stop loading
      isLoading.value = false;
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

    isLoading.value = true;

    try {
      // TODO: Implement your resend API call here
      // Example:
      // await AuthService.resendOtp(email);
      
      // Temporary: Remove when implementing
      await Future.delayed(const Duration(seconds: 1));

      // Clear existing OTP
      clearOtp();
      
      // Restart timer
      startResendTimer();

      Get.snackbar(
        'Success',
        'OTP code resent successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend OTP: ${e.toString()}',
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