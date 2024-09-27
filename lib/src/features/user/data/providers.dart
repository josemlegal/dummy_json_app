import 'package:dummy_json_app/core/network_client/network_client_provider.dart';
import 'package:dummy_json_app/src/features/user/data/datasources/remote_user_datasource.dart';
import 'package:dummy_json_app/src/features/user/data/repository/user_repository_implementation.dart';
import 'package:dummy_json_app/src/features/user/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final clientProvider = ref.read(apiHttpClientProvider);

  // final mockDatasource = MockProductDatasource();
  final remoteDatasource = RemoteUserDatasource(client: clientProvider);

  return UserRepositoryImpl(datasource: remoteDatasource);
}
