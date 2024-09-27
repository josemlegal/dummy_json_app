import 'package:dio/dio.dart';
import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_client_provider.g.dart';

@Riverpod(keepAlive: true)
NetworkClient apiHttpClient(ApiHttpClientRef ref) {
  return NetworkClient(
    dio: Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
      ),
    ),
  );
}
