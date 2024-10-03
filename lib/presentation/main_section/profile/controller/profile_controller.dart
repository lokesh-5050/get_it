import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_pref.dart';
import 'package:ecommerce_seller/core/shared_prefs/shared_prefs_key_constants.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Dio dio;

  ProfileController(this.dio);

  Future<bool> logout() async {
    await SharedPrefs.instance.removeKey(SharedPrefKeyConstants.isLoggedIn);
    await SharedPrefs.instance.removeKey(SharedPrefKeyConstants.apiToken);
    return Future.value(true);
  }
}
