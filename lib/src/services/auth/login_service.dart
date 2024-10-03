import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/core/failure.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';

class LoginService {
  final Dio dio;

  LoginService(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> login({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.post,
        ApiEndpoints.login,
        queryParams: data,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> verifyOtp({
    required Map<String, dynamic> data,
    required String accountId,
  }) async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.post,
        '${ApiEndpoints.verifyOtp}/$accountId',
        queryParams: data,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> register({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.post,
        ApiEndpoints.register,
        queryParams: data,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
