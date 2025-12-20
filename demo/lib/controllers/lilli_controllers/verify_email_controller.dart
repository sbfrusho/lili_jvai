import 'dart:async';
import 'dart:convert';
import 'package:demo/services/api_service.dart';
import 'package:demo/views/screens/Authentication/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  late List<TextEditingController> otpControllers;
  late List<FocusNode> focusNodes;
  final api = ApiService();

  final RxBool isLoading = false.obs;
  final RxBool isButtonEnabled = false.obs;
  final RxString otpError = ''.obs;
  final RxInt resendTimer = 60.obs;
  final RxBool canResend = false.obs;
  final RxString maskedEmail = ''.obs;

  Timer? _timer;
  String? email;

  @override
  void onInit() {
    super.onInit();

    otpControllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());

    for (int i = 0; i < 6; i++) {
      otpControllers[i].addListener(() => _onOtpChanged(i));
    }

    startResendTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }

  void _onOtpChanged(int index) {
    final text = otpControllers[index].text;

    if (otpError.value.isNotEmpty) {
      otpError.value = '';
    }

    if (text.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    _checkOtpComplete();
  }

  void onBackspace(int index) {
    if (otpControllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void _checkOtpComplete() {
    bool allFilled = otpControllers.every(
      (controller) => controller.text.isNotEmpty,
    );
    isButtonEnabled.value = allFilled;
  }

  String getOtpCode() {
    return otpControllers.map((controller) => controller.text).join();
  }

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

  Future<bool> verifyOtp(String email) async {
    if (!_validateOtp()) {
      return false;
    }

    isLoading.value = true;

    try {
      final otp = getOtpCode();
      print(otp.toString());

      // TODO: Implement your API call here
      // Example:
      // final response = await AuthService.verifyOtp(email, otp);
      isLoading(true);
      final response = await api.post("/otp/verify/", {
        "email": email,
        "otp": otp,
      });

      print("OTP Resopnse ================>>>>>>> ${response.toString()}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        print("OTP(email) Response==========>>>>>>$resBody");

        Get.off(() => LoginScreen());
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }

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
  Future<void> resendOtp(String email) async {
    if (!canResend.value) return;

    isLoading.value = true;

    try {
      isLoading(true);
      final response = await api.post("/otp/create/",{"email": email,});

      print(
        "RESEEND OTP Resopnse ================>>>>>>> ${response.toString()}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var resBody = json.decode(response.body);
        print("OTP(email) Response==========>>>>>>$resBody");

        // Get.off(() => LoginScreen());
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }

      await Future.delayed(const Duration(seconds: 1));

      clearOtp();

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

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
    isButtonEnabled.value = false;
    otpError.value = '';
  }

  void setEmail(String userEmail) {
    email = userEmail;
  }

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

  void pasteOtp(String text) {
    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) return;

    for (int i = 0; i < 6 && i < digits.length; i++) {
      otpControllers[i].text = digits[i];
    }

    final lastIndex = digits.length > 6 ? 5 : digits.length - 1;
    if (lastIndex >= 0 && lastIndex < 6) {
      focusNodes[lastIndex].requestFocus();
    }
  }
}
