import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/core/failure.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';

class ProductService {
  final Dio dio;

  ProductService(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> fetchTodayDeals() async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        ApiEndpoints.getTodayDeals,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> fetchNewArrivals() async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        ApiEndpoints.getNewArrivals,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
