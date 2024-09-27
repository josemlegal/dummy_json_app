import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/user/domain/entities/user_entity.dart';

abstract class UserDatasource {
  Future<Result<UserEntity>> getUser({required int userId});
}
