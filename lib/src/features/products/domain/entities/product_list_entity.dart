import 'package:dummy_json_app/src/features/products/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class ProductListEntity extends Equatable {
  const ProductListEntity({
    required this.products,
  });

  final List<ProductEntity> products;

  ProductListEntity copyWith({
    List<ProductEntity>? products,
  }) {
    return ProductListEntity(
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        products,
      ];
}
