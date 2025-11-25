import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool agreeTerms = false.obs;
  final RxString currentPassword = ''.obs; // Track password changes

  // Error messages
  final RxString nameError = ''.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString termsError = ''.obs;

  // Password strength indicator
  final RxDouble passwordStrength = 0.0.obs;
  final RxString passwordStrengthText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listeners for real-time validation
    nameController.addListener(_clearNameError);
    emailController.addListener(_clearEmailError);
    passwordController.addListener(() {
      _clearPasswordError();
      _checkPasswordStrength();
      currentPassword.value = passwordController.text; // Update observable
    });
    confirmPasswordController.addListener(_clearConfirmPasswordError);
  }

  @override
  void onClose() {
    // Dispose controllers
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Clear error methods
  void _clearNameError() {
    if (nameError.value.isNotEmpty) nameError.value = '';
  }

  void _clearEmailError() {
    if (emailError.value.isNotEmpty) emailError.value = '';
  }

  void _clearPasswordError() {
    if (passwordError.value.isNotEmpty) passwordError.value = '';
  }

  void _clearConfirmPasswordError() {
    if (confirmPasswordError.value.isNotEmpty) {
      confirmPasswordError.value = '';
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Toggle terms agreement
  void toggleAgreeTerms(bool? value) {
    agreeTerms.value = value ?? false;
    if (agreeTerms.value) {
      termsError.value = '';
    }
  }

  // Check password strength
  void _checkPasswordStrength() {
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordStrength.value = 0.0;
      passwordStrengthText.value = '';
      return;
    }

    double strength = 0.0;
    
    // Length check
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.15;
    
    // Has lowercase
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.15;
    
    // Has uppercase
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.15;
    
    // Has number
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.15;
    
    // Has special character
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.15;

    passwordStrength.value = strength;

    if (strength <= 0.3) {
      passwordStrengthText.value = 'Weak';
    } else if (strength <= 0.6) {
      passwordStrengthText.value = 'Medium';
    } else {
      passwordStrengthText.value = 'Strong';
    }
  }

  // Validate name
  bool _validateName() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      nameError.value = 'Full name is required';
      return false;
    }
    if (name.length < 2) {
      nameError.value = 'Name must be at least 2 characters';
      return false;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      nameError.value = 'Name can only contain letters';
      return false;
    }
    nameError.value = '';
    return true;
  }

  // Validate email
  bool _validateEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      return false;
    }
    emailError.value = '';
    return true;
  }

  // Validate password
  bool _validatePassword() {
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      return false;
    }
    if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      passwordError.value = 'Password must contain uppercase letter';
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      passwordError.value = 'Password must contain lowercase letter';
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      passwordError.value = 'Password must contain a number';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  // Validate confirm password
  bool _validateConfirmPassword() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return false;
    }
    if (password != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }
    confirmPasswordError.value = '';
    return true;
  }

  // Validate terms
  bool _validateTerms() {
    if (!agreeTerms.value) {
      termsError.value = 'You must agree to the terms';
      Get.snackbar(
        'Terms Required',
        'Please agree to Terms of Service and Privacy Policy',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    termsError.value = '';
    return true;
  }

  // Validate all fields
  bool _validateForm() {
    final isNameValid = _validateName();
    final isEmailValid = _validateEmail();
    final isPasswordValid = _validatePassword();
    final isConfirmPasswordValid = _validateConfirmPassword();
    final isTermsValid = _validateTerms();
    
    return isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isConfirmPasswordValid &&
        isTermsValid;
  }

  // Sign Up function
  Future<void> signUp() async {
    // Validate form
    if (!_validateForm()) {
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // TODO: Implement your API call here
      // Example:
      // final name = nameController.text.trim();
      // final email = emailController.text.trim();
      // final password = passwordController.text;
      // final response = await AuthService.signUp(name, email, password);
      
      // Temporary: Remove this delay when implementing API
      await Future.delayed(const Duration(seconds: 1));
      Get.to(LoginScreen());
      
      // TODO: After successful API call, navigate to home or verification
      // Get.offAllNamed('/home'); // Or '/verify-email'

    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Sign up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  // Social sign up - Google
  Future<void> signUpWithGoogle() async {
    isLoading.value = true;
    try {
      // TODO: Implement Google Sign-In
      
      // Temporary: Remove when implementing
      await Future.delayed(const Duration(seconds: 1));

    } catch (e) {
      Get.snackbar(
        'Error',
        'Google sign up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Social sign up - Apple
  Future<void> signUpWithApple() async {
    isLoading.value = true;
    try {
      // TODO: Implement Apple Sign-In
      
      // Temporary: Remove when implementing
      await Future.delayed(const Duration(seconds: 1));

    } catch (e) {
      Get.snackbar(
        'Error',
        'Apple sign up failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Login
  void navigateToLogin() {
    Get.back(); // Or Get.toNamed('/login')
  }

  // Clear all fields
  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    agreeTerms.value = false;
    nameError.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    termsError.value = '';
    passwordStrength.value = 0.0;
    passwordStrengthText.value = '';
  }
}