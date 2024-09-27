import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/user/domain/datasources/user_datasource.dart';
import 'package:dummy_json_app/src/features/user/domain/entities/user_entity.dart';
import 'package:dummy_json_app/src/features/user/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({
    required this.datasource,
  });

  final UserDatasource datasource;

  @override
  Future<Result<UserEntity>> getUser({required int userId}) {
    return datasource.getUser(userId: userId);
  }
}
