import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/presentation/main_section/profile/controller/profile_controller.dart';
import 'package:ecommerce_seller/presentation/on_boarding_section/login_screen/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InjectDependencies {
  static Future<void> inject() async {
    await injectDio();
    await injectControllers();
  }

  static Future<void> injectDio() async {
    Dio dio = Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl));
    Get.lazyPut<Dio>(() => dio);
    debugPrint("Dio Successfully Injected!");
  }

  static Future<void> injectControllers() async {
    final dio = Get.find<Dio>();
    Get.lazyPut<LoginController>(
      () => LoginController(dio),
    );

    Get.lazyPut<ProfileController>(
      () => ProfileController(dio),
    );

    debugPrint("Controllers Successfully Injected!");
  }
}
