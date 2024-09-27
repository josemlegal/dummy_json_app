import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/user/data/models/user_model.dart';
import 'package:dummy_json_app/src/features/user/domain/datasources/user_datasource.dart';
import 'package:dummy_json_app/src/features/user/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

class RemoteUserDatasource extends UserDatasource {
  RemoteUserDatasource({
    required NetworkClient client,
  }) : _client = client;

  final NetworkClient _client;

  @override
  Future<Result<UserEntity>> getUser({required int userId}) async {
    final response = await _client.get(
      '/user/$userId',
      fromJsonFunction: UserModel.fromJson,
    );

    return response.flatMap(
      (data) => right(data.toEntity()),
    );
  }
}
