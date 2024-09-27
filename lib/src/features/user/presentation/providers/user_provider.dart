import 'package:dummy_json_app/core/network_client/netwok_client.dart';
import 'package:dummy_json_app/src/features/user/data/providers.dart';

import 'package:dummy_json_app/src/features/user/domain/entities/user_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<Result<UserEntity>> getUser(GetUserRef ref) async {
  final repository = ref.read(userRepositoryProvider);

  return repository.getUser(userId: 1);
}
