import 'dart:convert';

import 'package:demo/models/lilli_models/login_response_model.dart';
import 'package:demo/services/api_service.dart';
import 'package:demo/services/shared_prefs_service.dart';
import 'package:demo/views/screens/Home%20Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;

  // Form validation
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final api = ApiService();
  var sharePrefs = SharedPrefsService();

  @override
  void onInit() {
    super.onInit();
    // Add listeners if needed
    emailController.addListener(_clearEmailError);
    passwordController.addListener(_clearPasswordError);
  }

  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Clear error when user starts typing
  void _clearEmailError() {
    if (emailError.value.isNotEmpty) {
      emailError.value = '';
    }
  }

  void _clearPasswordError() {
    if (passwordError.value.isNotEmpty) {
      passwordError.value = '';
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool value) {
    rememberMe.value = value;
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
    if (password.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  // Validate all fields
  bool _validateForm() {
    final isEmailValid = _validateEmail();
    final isPasswordValid = _validatePassword();
    return isEmailValid && isPasswordValid;
  }

  // Login function
  Future<void> login() async {
    // Validate form
    if (!_validateForm()) {
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Example:
      final email = emailController.text.trim();
      final password = passwordController.text;
      // final response = await AuthService.login(email, password);


      isLoading(true);
      final response = await api.post("/login/", {
        "email": email,
        "password": password,
      });
      // print("Login Response==========>>>>>>$response");
      // Temporary: Remove this delay when implementing API
      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        // print("Login Response==========>>>>>>$resBody");
        var loiginRes = LoginResponseModel.fromJson(resBody);
        await SharedPrefsService.set("accessToken", loiginRes.accessToken);
        await SharedPrefsService.set("refreshToken", loiginRes.refreshToken);

        Get.off(()=>HomeScreen());
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
      
      // Temporary: Remove this delay when implementing API
      await Future.delayed(const Duration(seconds: 1));
      Get.to(()=>HomeScreen(),transition: .noTransition,duration: Duration(seconds: 0));
      // Get.offAllNamed('/home');

    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
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

  // Social login - Google
  Future<void> loginWithGoogle() async {
    isLoading.value = true;
    try {
      // TODO: Implement Google Sign-In
      
      // Temporary: Remove when implementing
      await Future.delayed(const Duration(seconds: 1));

    } catch (e) {
      Get.snackbar(
        'Error',
        'Google login failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Social login - Apple
  Future<void> loginWithApple() async {
    isLoading.value = true;
    try {
      // TODO: Implement Apple Sign-In
      
      // Temporary: Remove when implementing
      await Future.delayed(const Duration(seconds: 1));

    } catch (e) {
      Get.snackbar(
        'Error',
        'Apple login failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Forgot Password
  void navigateToForgotPassword() {
    Get.toNamed('/forgot-password'); // Or Get.to(() => ForgotPasswordScreen())
  }

  // Navigate to Sign Up
  void navigateToSignUp() {
    Get.toNamed('/sign-up'); // Or Get.to(() => SignUpScreen())
  }

  // Clear all fields
  void clearFields() {
    emailController.clear();
    passwordController.clear();
    emailError.value = '';
    passwordError.value = '';
  }
}