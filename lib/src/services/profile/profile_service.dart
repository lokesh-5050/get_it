import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_seller/core/api_endpoints.dart';
import 'package:ecommerce_seller/core/failure.dart';
import 'package:ecommerce_seller/utilz/enums.dart';
import 'package:ecommerce_seller/utilz/helpers.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<Either<Failure, Map<String, dynamic>>> getMyProfile() async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.get,
        ApiEndpoints.myProfile,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
