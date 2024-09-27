import 'package:dummy_json_app/core/network_client/api_exception.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';

typedef Result<T> = Either<ApiException, T>;

class NetworkClient {
  const NetworkClient({
    required this.dio,
  });

  final Dio dio;

  Future<Result<T>> post<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJsonFunction,
    dynamic body,
    Map<String, dynamic>? aditionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    final options = Options(
      headers: aditionalHeaders,
    );

    try {
      final response = await dio.post(
        path,
        data: body,
        options: options,
        queryParameters: queryParameters,
      );

      return right(fromJsonFunction(response.data));
    } on Exception catch (error) {
      return left(ApiException(message: error.toString()));
    }
  }

  Future<Result<T>> get<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJsonFunction,
    Map<String, dynamic>? aditionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) async {
    final options = Options(
      headers: aditionalHeaders,
    );

    try {
      final response = await dio.get(
        path,
        options: options,
        queryParameters: queryParameters,
      );

      return right(fromJsonFunction(response.data));
    } on Exception catch (error) {
      return left(ApiException(message: error.toString()));
    }
  }
}
