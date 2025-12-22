import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:demo/services/api_service.dart';
import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:flutter/foundation.dart';
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
  final RxString currentNewPassword = ''.obs;
  final RxString currentConfirmPassword = ''.obs;

  // Password strength
  final RxDouble passwordStrength = 0.0.obs;
  final RxString passwordStrengthText = ''.obs;
  
  // Password requirements
  final RxBool hasMinLength = false.obs;
  final RxBool hasUppercase = false.obs;
  final RxBool hasLowercase = false.obs;
  final RxBool hasNumber = false.obs;
  final RxBool hasSpecialChar = false.obs;

  // Email and OTP from previous screens
  String? email;
  String? otp;
  final api = ApiService();

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

  // Set email and OTP from previous screens
  void setEmail(String userEmail) {
    email = userEmail;
    if (kDebugMode) {
      print("Email set in NewPasswordController: $email");
    }
  }

  void setOtp(String userOtp) {
    otp = userOtp;
    if (kDebugMode) {
      print("OTP set in NewPasswordController: $otp");
    }
  }

  void setEmailAndOtp(String userEmail, String userOtp) {
    email = userEmail;
    otp = userOtp;
    if (kDebugMode) {
      print("Email and OTP set in NewPasswordController - Email: $email, OTP: $otp");
    }
  }

  // Handle new password changes
  void _onNewPasswordChanged() {
    _checkPasswordRequirements();
    _checkPasswordStrength();
    _validatePasswords();
    currentNewPassword.value = newPasswordController.text;
    
    // Clear error when typing
    if (newPasswordError.value.isNotEmpty) {
      newPasswordError.value = '';
    }
  }

  // Handle confirm password changes
  void _onConfirmPasswordChanged() {
    _validatePasswords();
    currentConfirmPassword.value = confirmPasswordController.text;
    
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
    // Check if email and OTP are set
    if (email == null || email!.isEmpty) {
      _showErrorSnackbar(
        'Error',
        'Email not found. Please try again from the beginning.',
      );
      return false;
    }

    if (otp == null || otp!.isEmpty) {
      _showErrorSnackbar(
        'Error',
        'OTP not found. Please verify OTP again.',
      );
      return false;
    }

    // Validate form
    if (!_validateForm()) {
      return false;
    }

    // Start loading
    isLoading.value = true;

    try {
      final newPassword = newPasswordController.text;
      final confirmPassword = confirmPasswordController.text;

      if (kDebugMode) {
        print("Updating password for email: $email");
        print("Using OTP: $otp");
      }

      // Call API to update password
      // NOTE: Verify with your backend if they need both new_password and confirm_password
      // Some backends only need new_password or password
      final response = await api.post("/password-reset/confirm/", {
        "email": email,
        "otp": otp,
        "new_password": newPassword,
        "confirm_password": confirmPassword,
      });

      if (kDebugMode) {
        print("Password Update Response Status: ${response.statusCode}");
        print("Password Update Response Body: ${response.body}");
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response safely
        try {
          var resBody = json.decode(response.body);
          if (kDebugMode) {
            print("Password Reset Success: $resBody");
          }

          // Success message
          if (!isClosed) {
            Get.snackbar(
              'Success',
              'Password updated successfully!',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(seconds: 2),
              icon: const Icon(Icons.check_circle, color: Colors.white),
            );
          }

          // Navigate to login screen
          await Future.delayed(const Duration(milliseconds: 500));
          
          if (!isClosed) {
            Get.offAll(
              () => const LoginScreen(),
              transition: Transition.noTransition,
            );
          }

          return true;
        } catch (e) {
          if (kDebugMode) {
            print("JSON parsing error: $e");
          }
          _showErrorSnackbar('Error', 'Invalid response from server');
          return false;
        }
      } else {
        // Handle error response
        String errorMsg = "Failed to update password";
        
        try {
          var errorBody = jsonDecode(response.body);
          
          if (errorBody is Map) {
            // Try different error field names
            if (errorBody['message'] != null) {
              errorMsg = errorBody['message'].toString();
            } else if (errorBody['error'] != null) {
              errorMsg = errorBody['error'].toString();
            } else if (errorBody['detail'] != null) {
              errorMsg = errorBody['detail'].toString();
            }
            
            // Check for nested errors
            if (errorBody['errors'] != null) {
              final errors = errorBody['errors'];
              if (errors is Map) {
                // Get first error message
                if (errors.isNotEmpty) {
                  final firstKey = errors.keys.first;
                  final firstError = errors[firstKey];
                  if (firstError is List && firstError.isNotEmpty) {
                    errorMsg = firstError[0].toString();
                  } else {
                    errorMsg = firstError.toString();
                  }
                }
              } else if (errors is String) {
                errorMsg = errors;
              }
            }
            
            // Check for field-specific errors
            if (errorBody['new_password'] != null) {
              final pwdError = errorBody['new_password'];
              if (pwdError is List && pwdError.isNotEmpty) {
                errorMsg = pwdError[0].toString();
              }
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print("Error parsing error response: $e");
          }
        }
        
        _showErrorSnackbar('Error', errorMsg);
        return false;
      }
    } on SocketException {
      // No internet connection
      _showErrorSnackbar(
        'Connection Error',
        'Please check your internet connection',
      );
      return false;
    } on TimeoutException {
      // Request timeout
      _showErrorSnackbar(
        'Timeout',
        'Request took too long. Please try again',
      );
      return false;
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print("Password update error: $e");
      }
      
      _showErrorSnackbar(
        'Error',
        'Failed to update password: ${e.toString()}',
      );
      return false;
    } finally {
      // Stop loading
      if (!isClosed) {
        isLoading.value = false;
      }
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

  // Helper method to show error snackbar
  void _showErrorSnackbar(String title, String message) {
    if (!isClosed) {
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
  }
}