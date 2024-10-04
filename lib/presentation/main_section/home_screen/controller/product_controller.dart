import 'package:dio/dio.dart';
import 'package:ecommerce_seller/src/model/category/category_model.dart';
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
    // getAllCategory();
    // getAllSubCategory();
    // fetchTodayDeals();
    // fetchNewArrivals();
  }

  void clear() {
    getTodayDeals = [];
    getNewArrivals = [];
    product = ProductModel();
    products = [];
    allCategory = [];
    allSubCategory = [];
  }

  late ProductService productService = ProductService(dio);

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

  List<CategoryModel> _allCategory = [];

  List<CategoryModel> _allSubCategory = [];

  List<ProductModel> _products = [];

  Status _productsStatus = Status.loading;

  Status get productsStatus => _productsStatus;

  List<ProductModel> get products => _products;

  ProductModel _product = ProductModel();

  Status _productStatus = Status.loading;

  Status get productStatus => _productStatus;

  ProductModel get product => _product;

  set product(ProductModel data) {
    _product = data;
    update();
  }

  set productsStatus(Status status) {
    _productsStatus = status;
    update();
  }

  set productStatus(Status status) {
    _productStatus = status;
    update();
  }

  set products(List<ProductModel> data) {
    _products = data;
    update();
  }

  Status _categoryStatus = Status.loading;

  Status get categoryStatus => _categoryStatus;

  set categoryStatus(Status status) {
    _categoryStatus = status;
    update();
  }

  List<CategoryModel> get allCategory => _allCategory;

  set allCategory(List<CategoryModel> list) {
    _allCategory = list;
    update();
  }

  Status _subCategoryStatus = Status.success;

  Status get subCategoryStatus => _subCategoryStatus;

  List<CategoryModel> get allSubCategory => _allSubCategory;

  set subCategoryStatus(Status status) {
    _categoryStatus = status;
    update();
  }

  set allSubCategory(List<CategoryModel> list) {
    _allSubCategory = list;
    update();
  }

  Future<void> fetchTodayDeals() async {
    getTodayDealsStatus = Status.loading;
    final response = await productService.fetchTodayDeals();

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
    final response = await productService.fetchNewArrivals();

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

  Future<void> getAllCategory() async {
    categoryStatus = Status.loading;
    final response = await productService.getAllCategory();

    response.fold((isFailure) {
      debugPrint(
          'Error in fetching category : ${Helpers.convertFailureToMessage(isFailure)}');
      categoryStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        List<CategoryModel> list = success['data']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();
        allCategory = list;
        categoryStatus = Status.success;
      }
    });
  }

  Future<void> getAllSubCategory() async {
    subCategoryStatus = Status.loading;
    final response = await productService.getAllSubCategory();

    response.fold((isFailure) {
      debugPrint(
          'Error in fetching category : ${Helpers.convertFailureToMessage(isFailure)}');
      subCategoryStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        List<CategoryModel> list = success['data']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();
        allSubCategory = list;
        subCategoryStatus = Status.success;
      }
    });
  }

  Future<void> getProductsByMainCategory(
      {required String mainCategoryId}) async {
    productsStatus = Status.loading;
    final response = await productService.getProductsByMainCategory(
        mainCategoryId: mainCategoryId);

    response.fold((isFailure) {
      debugPrint(
          'Error in getProductsByMainCategory : ${Helpers.convertFailureToMessage(isFailure)}');
      productsStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        List<ProductModel> list = success['data']
            .map<ProductModel>((e) => ProductModel.fromJson(e))
            .toList();
        products = list;
        productsStatus = Status.success;
      }
    });
  }

  Future<void> getProductId({required String productId}) async {
    productStatus = Status.loading;
    final response = await productService.getProductId(productId: productId);

    response.fold((isFailure) {
      debugPrint(
          'Error in getProductId : ${Helpers.convertFailureToMessage(isFailure)}');
      productStatus = Status.failed;
    }, (success) {
      if (success['data'] != null || success['data'] != {}) {
        ProductModel data = ProductModel.fromJson(success['data']);
        product = data;
        productStatus = Status.success;
      }
    });
  }
}
