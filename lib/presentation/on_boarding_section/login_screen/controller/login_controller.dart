import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_pref.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_prefs_key_constants.dart';
import 'package:ecommerce_seller/presentation/main_section/bottom_navigation/bottom_navigation_screen.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/otp/otp_screen.dart';
import 'package:ecommerce_seller/src/services/auth/login_service.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final Dio dio;

  LoginController(this.dio);

  late LoginService loginService = LoginService(dio);

  RxString selectedValue = 'Login'.obs;

  final loginStatus = Status.success.obs;

  final loginOtpStatus = Status.success.obs;

  final loginOtpVerifyStatus = Status.success.obs;

  changingSelectedOption(String login) {
    selectedValue.value = login;
  }

  Future<bool> login(
      {String email = "",
      String? password = "",
      bool loginWithEmail = true,
      int? mobileNo}) async {
    loginWithEmail
        ? loginStatus.value = Status.loading
        : loginOtpStatus.value = Status.loading;

    //validations
    if (loginWithEmail && email.trim().isEmpty) {
      Helpers.cupertinoAlertPopUp("Enter email", () => Get.back());
      loginStatus.value = Status.failed;
      return false;
    } else if (loginWithEmail && password!.trim().length < 4) {
      Helpers.cupertinoAlertPopUp(
          "Password must be greater than 4", () => Get.back());
      loginStatus.value = Status.failed;
      return false;
    }

    Map<String, dynamic> data = {};

    loginWithEmail
        ? data.addAll({'email': email, 'password': password})
        : data.addAll({'mobileNumber': mobileNo});

    final response = await loginService.login(data: data);

    response.fold((isFailure) {
      loginWithEmail
          ? loginStatus.value = Status.failed
          : loginOtpStatus.value = Status.failed;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(Helpers.convertFailureToMessage(isFailure))));
    }, (success) {
      if (!loginWithEmail) {
        Map<String, dynamic> data = success['data'];
        String otp = data['otp'].toString();
        String accountId = data['_id'].toString();
        loginOtpStatus.value = Status.success;
        Get.to(() => OtpScreen(
              mobileNo: mobileNo.toString(),
              demoOtp: otp,
              accountId: accountId,
            ));
        return true;
      } else {
        loginStatus.value = Status.success;
        SharedPrefs.instance.setKey(SharedPrefKeyConstants.isLoggedIn, true);
        SharedPrefs.instance
            .setKey(SharedPrefKeyConstants.apiToken, success['token']);
      }
    });

    return response.isRight();
  }

  Future<bool> verifyOtp(
      {required String otp, required String accountId}) async {
    if (otp.isEmpty) {
      Helpers.cupertinoAlertPopUp(
          "Password must be greater than 4", () => Get.back());
      return false;
    } else if (accountId.isEmpty) {
      Helpers.cupertinoAlertPopUp(
          "Password must be greater than 4", () => Get.back());
      return false;
    }

    loginOtpVerifyStatus.value = Status.loading;

    final response =
        await loginService.verifyOtp(data: {'otp': otp}, accountId: accountId);

    response.fold((isFailure) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(Helpers.convertFailureToMessage(isFailure))));
    }, (success) {
      debugPrint('Otp verified');
      SharedPrefs.instance.setKey(SharedPrefKeyConstants.isLoggedIn, true);
      SharedPrefs.instance
          .setKey(SharedPrefKeyConstants.apiToken, success['token']);
      Get.offAll(() => const BottomNavigation());
    });

    return response.isRight();
  }
}
