import 'package:dummy_json_app/src/features/favorites/data/datasources/local_favorites_datasource.dart';
import 'package:dummy_json_app/src/features/favorites/data/repository/favorites_repository_implementation.dart';
import 'package:dummy_json_app/src/features/favorites/domain/repository/favorites_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'providers.g.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

@riverpod
FavoritesRepository favoritesRepository(FavoritesRepositoryRef ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);

  final localDatasource =
      LocalFavoriteDatasource(sharedPreferences: sharedPreferences);

  return FavoritesRepositoryImpl(datasource: localDatasource);
}
