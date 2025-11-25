import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  // Text Controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool passwordsMatch = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxString newPasswordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString currentNewPassword = ''.obs; // Track new password changes
  final RxString currentConfirmPassword = ''.obs; // Track confirm password changes

  // Password strength
  final RxDouble passwordStrength = 0.0.obs;
  final RxString passwordStrengthText = ''.obs;
  
  // Password requirements
  final RxBool hasMinLength = false.obs;
  final RxBool hasUppercase = false.obs;
  final RxBool hasLowercase = false.obs;
  final RxBool hasNumber = false.obs;
  final RxBool hasSpecialChar = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Add listeners
    newPasswordController.addListener(_onNewPasswordChanged);
    confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  @override
  void onClose() {
    // Dispose controllers
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Handle new password changes
  void _onNewPasswordChanged() {
    _checkPasswordRequirements();
    _checkPasswordStrength();
    _validatePasswords();
    currentNewPassword.value = newPasswordController.text; // Update observable
    
    // Clear error when typing
    if (newPasswordError.value.isNotEmpty) {
      newPasswordError.value = '';
    }
  }

  // Handle confirm password changes
  void _onConfirmPasswordChanged() {
    _validatePasswords();
    currentConfirmPassword.value = confirmPasswordController.text; // Update observable
    
    // Clear error when typing
    if (confirmPasswordError.value.isNotEmpty) {
      confirmPasswordError.value = '';
    }
  }

  // Check password requirements
  void _checkPasswordRequirements() {
    final password = newPasswordController.text;

    hasMinLength.value = password.length >= 8;
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    hasNumber.value = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    // Check if password is valid (all requirements met)
    isPasswordValid.value = hasMinLength.value &&
        hasUppercase.value &&
        hasLowercase.value &&
        hasNumber.value;
  }

  // Check password strength
  void _checkPasswordStrength() {
    final password = newPasswordController.text;
    
    if (password.isEmpty) {
      passwordStrength.value = 0.0;
      passwordStrengthText.value = '';
      return;
    }

    double strength = 0.0;

    // Length check
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.15;
    if (password.length >= 16) strength += 0.1;

    // Character variety
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.1;

    passwordStrength.value = strength.clamp(0.0, 1.0);

    // Set strength text
    if (strength < 0.4) {
      passwordStrengthText.value = 'Weak';
    } else if (strength < 0.7) {
      passwordStrengthText.value = 'Medium';
    } else {
      passwordStrengthText.value = 'Strong';
    }
  }

  // Validate passwords
  void _validatePasswords() {
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    // Check if passwords match
    if (newPass.isNotEmpty && confirmPass.isNotEmpty) {
      passwordsMatch.value = newPass == confirmPass && isPasswordValid.value;
    } else {
      passwordsMatch.value = false;
    }
  }

  // Validate new password
  bool _validateNewPassword() {
    final password = newPasswordController.text;

    if (password.isEmpty) {
      newPasswordError.value = 'Password is required';
      return false;
    }

    if (password.length < 8) {
      newPasswordError.value = 'Password must be at least 8 characters';
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      newPasswordError.value = 'Password must contain an uppercase letter';
      return false;
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      newPasswordError.value = 'Password must contain a lowercase letter';
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      newPasswordError.value = 'Password must contain a number';
      return false;
    }

    newPasswordError.value = '';
    return true;
  }

  // Validate confirm password
  bool _validateConfirmPassword() {
    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (confirmPass.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return false;
    }

    if (newPass != confirmPass) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }

    confirmPasswordError.value = '';
    return true;
  }

  // Validate all fields
  bool _validateForm() {
    final isNewPasswordValid = _validateNewPassword();
    final isConfirmPasswordValid = _validateConfirmPassword();
    
    return isNewPasswordValid && isConfirmPasswordValid;
  }

  // Update password
  Future<bool> updatePassword() async {
    // Validate form
    if (!_validateForm()) {
      return false;
    }

    // Start loading
    isLoading.value = true;

    try {
      // TODO: Implement your API call here
      // Example:
      // final newPassword = newPasswordController.text;
      // final response = await AuthService.resetPassword(otp, newPassword);
      
      // Temporary: Remove this delay when implementing API
      await Future.delayed(const Duration(seconds: 1));
      Get.to(LoginScreen());

      // Success message
      Get.snackbar(
        'Success',
        'Password updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // TODO: Navigate to login after API success
      // await Future.delayed(const Duration(milliseconds: 500));
      // Get.offAllNamed('/login'); // Or Get.offAll(() => LoginScreen())

      return true;

    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to update password: ${e.toString()}',
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

  // Clear all fields
  void clearFields() {
    newPasswordController.clear();
    confirmPasswordController.clear();
    passwordsMatch.value = false;
    isPasswordValid.value = false;
    newPasswordError.value = '';
    confirmPasswordError.value = '';
    passwordStrength.value = 0.0;
    passwordStrengthText.value = '';
    hasMinLength.value = false;
    hasUppercase.value = false;
    hasLowercase.value = false;
    hasNumber.value = false;
    hasSpecialChar.value = false;
  }

  // Get password requirements status
  List<Map<String, dynamic>> getPasswordRequirements() {
    return [
      {
        'text': 'At least 8 characters',
        'met': hasMinLength.value,
      },
      {
        'text': 'One uppercase letter',
        'met': hasUppercase.value,
      },
      {
        'text': 'One lowercase letter',
        'met': hasLowercase.value,
      },
      {
        'text': 'One number',
        'met': hasNumber.value,
      },
    ];
  }
}