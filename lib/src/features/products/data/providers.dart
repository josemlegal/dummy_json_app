import 'package:dummy_json_app/core/network_client/network_client_provider.dart';
import 'package:dummy_json_app/src/features/products/data/datasources/data_sources.dart';
import 'package:dummy_json_app/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:dummy_json_app/src/features/products/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  final clientProvider = ref.read(apiHttpClientProvider);

  // final mockDatasource = MockProductDatasource();
  final remoteDatasource = RemoteProductDatasource(client: clientProvider);

  return ProductRepositoryImpl(datasource: remoteDatasource);
}
