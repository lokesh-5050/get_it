import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/core/failure.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';

class CartService {
  final Dio dio;

  CartService(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> getCart() async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        ApiEndpoints.getCart,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> addToCart(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.addToCart,
          queryParams: data);
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> updateCartQuantity(
      {required Map<String, dynamic> data}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.put, ApiEndpoints.updateCartQuantity,
          queryParams: data);
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteCardProductById(
      {required String productId}) async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.delete,
        '${ApiEndpoints.deleteCardProductById}/$productId',
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
