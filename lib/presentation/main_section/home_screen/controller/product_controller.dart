import 'package:dio/dio.dart';
import 'package:ecommerce_seller/src/model/product/product_model.dart';
import 'package:ecommerce_seller/src/services/product/product_service.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final Dio dio;

  ProductController(this.dio);

  @override
  void onInit() {
    super.onInit();
    fetchTodayDeals();
    fetchNewArrivals();
  }

  late ProductService getTodayDealsService = ProductService(dio);

  List<ProductModel> _getTodayDeals = [];

  List<ProductModel> _getNewArrivals = [];

  List<ProductModel> get getTodayDeals => _getTodayDeals;

  List<ProductModel> get getNewArrivals => _getNewArrivals;

  set getTodayDeals(List<ProductModel> list) {
    _getTodayDeals = list;
    update();
  }

  set getNewArrivals(List<ProductModel> list) {
    _getNewArrivals = list;
    update();
  }

  Status _getTodayDealsStatus = Status.loading;

  Status _getNewArrivalsStatus = Status.loading;

  Status get getTodayDealsStatus => _getTodayDealsStatus;

  Status get getNewArrivalsStatus => _getNewArrivalsStatus;

  set getTodayDealsStatus(Status status) {
    _getTodayDealsStatus = status;
    update();
  }

  set getNewArrivalsStatus(Status status) {
    _getNewArrivalsStatus = status;
    update();
  }

  Future<void> fetchTodayDeals() async {
    getTodayDealsStatus = Status.loading;
    final response = await getTodayDealsService.fetchTodayDeals();

    response.fold((isFailure) {
      debugPrint(
          'Error in fetching fetchTodayDeals : ${Helpers.convertFailureToMessage(isFailure)}');
      getTodayDealsStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        List<ProductModel> list = success['data']
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
        getTodayDeals = list;
        getTodayDealsStatus = Status.success;
      }
    });
  }

  Future<void> fetchNewArrivals() async {
    getNewArrivalsStatus = Status.loading;
    final response = await getTodayDealsService.fetchNewArrivals();

    response.fold((isFailure) {
      debugPrint(
          'Error in fetching fetchNewArrivals : ${Helpers.convertFailureToMessage(isFailure)}');
      getNewArrivalsStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        List<ProductModel> list = success['data']
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
        getNewArrivals = list;
        getNewArrivalsStatus = Status.success;
      }
    });
  }
}
