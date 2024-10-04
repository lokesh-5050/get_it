import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_pref.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_prefs_key_constants.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/controller/cart_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
import 'package:ecommerce_seller/src/model/profile/user_model.dart';
import 'package:ecommerce_seller/src/services/profile/profile_service.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Dio dio;

  ProfileController(this.dio);

  void clear() {
    profileData.value = UserModel();
    profileStatus.value = Status.success;
  }

  late ProfileService profileService = ProfileService(dio);

  final profileStatus = Status.success.obs;
  final profileData = UserModel().obs;

  Future<void> getMyProfile() async {
    profileStatus.value = Status.loading;

    final response = await profileService.getMyProfile();

    response.fold((isFailure) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(Helpers.convertFailureToMessage(isFailure))));
      profileStatus.value = Status.failed;
    }, (success) {
      UserModel userModel = UserModel.fromJson(success['data']);
      debugPrint(
          'value of User : ${userModel.user?.userName} and _id : ${userModel.user?.sId}');
      profileData.value = userModel;
      profileStatus.value = Status.success;
    });
  }

  Future<bool> logout() async {
    await SharedPrefs.instance.removeKey(SharedPrefKeyConstants.isLoggedIn);
    await SharedPrefs.instance.removeKey(SharedPrefKeyConstants.apiToken);
    Get.find<ProductController>().clear();
    Get.find<CartController>().clear();
    Get.find<ProfileController>().clear();
    return Future.value(true);
  }
}
