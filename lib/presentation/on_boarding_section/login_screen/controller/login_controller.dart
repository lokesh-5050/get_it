import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/shared_pref.dart';
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

  changingSelectedOption(String login) {
    selectedValue.value = login;
  }

  Future<bool> login(
      {String email = "",
      required String password,
      bool loginWithEmail = true,
      int? mobileNo}) async {
    loginStatus.value = Status.loading;

    //validations
    if (email.trim().isEmpty) {
      Helpers.cupertinoAlertPopUp("Enter email", () => Get.back());
      loginStatus.value = Status.failed;
      return false;
    } else if (loginWithEmail && password.trim().length < 4) {
      Helpers.cupertinoAlertPopUp(
          "Password must be greater than 4", () => Get.back());
      loginStatus.value = Status.failed;
      return false;
    }

    Map<String, dynamic> data = {'password': password};

    loginWithEmail
        ? data.addAll({'email': email})
        : data.addAll({'mobile': mobileNo});

    final response = await loginService.login(data: data);

    response.fold((isFailure) {
      debugPrint('Login Error : ${Helpers.convertFailureToMessage(isFailure)}');
      loginStatus.value = Status.failed;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text("${Helpers.convertFailureToMessage(isFailure)}")));
    }, (success) {
      debugPrint('Logged IN => ${success['token']}');
      SharedPrefs.instance.setKey('isLoggedIn', true);

      SharedPrefs.instance.setKey('apiToken', success['token']);
    });

    return response.isRight();
  }
}
