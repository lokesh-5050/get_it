import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/presentation/main_section/bottom_navigation/controller/bottom_navigation_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/controller/cart_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/cart/controller/cart_controller.dart';
import 'package:ecommerce_seller/presentation/main_section/home_screen/controller/product_controller.dart';
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

    Get.put(LoginController(dio));

    Get.lazyPut(() => BottomNavigationController(), fenix: true);

    Get.lazyPut<ProfileController>(() => ProfileController(dio), fenix: true);

    Get.lazyPut<ProductController>(() => ProductController(dio));

    Get.lazyPut<CartController>(() => CartController(dio),fenix: true);

    debugPrint("Controllers Successfully Injected!");
  }
}
