import 'package:dio/dio.dart';
import 'package:ecommerce_seller/src/model/category/category_model.dart';
import 'package:ecommerce_seller/src/services/category/category_service.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final Dio dio;

  CategoryController(this.dio);

  late CategoryService categoryService = CategoryService(dio);

  List<CategoryModel> _allCategory = [];

  List<CategoryModel> _allSubCategory = [];

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

  set subCategoryStatus(Status status) {
    _categoryStatus = status;
    update();
  }

  List<CategoryModel> get allSubCategory => _allSubCategory;

  set allSubCategory(List<CategoryModel> list) {
    _allSubCategory = list;
    update();
  }

  Future<void> getAllCategory() async {
    categoryStatus = Status.loading;
    final response = await categoryService.getAllCategory();

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
    final response = await categoryService.getAllSubCategory();

    response.fold((isFailure) {
      debugPrint(
          'Error in fetching category : ${Helpers.convertFailureToMessage(isFailure)}');
      subCategoryStatus = Status.failed;
    }, (success) {
      if (success['data'].length != 0) {
        debugPrint('Sub Categody : ${success['data']}');
        List<CategoryModel> list = success['data']
            .map<CategoryModel>((e) => CategoryModel.fromJson(e))
            .toList();
        allSubCategory = list;
        subCategoryStatus = Status.success;
      }
    });
  }
}
