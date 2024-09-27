import 'package:dummy_json_app/src/features/products/data/models/product_model.dart';
import 'package:dummy_json_app/src/features/products/domain/entities/product_list_entity.dart';

class ProductListModel {
  List<ProductModel> products;

  ProductListModel({
    required this.products,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: List<ProductModel>.from(
        (json['products'] as List<dynamic>).map(
          (product) => ProductModel.fromMap(product as Map<String, dynamic>),
        ),
      ),
    );
  }

  ProductListEntity toEntity() {
    return ProductListEntity(
      products: products.map((product) => product.toEntity()).toList(),
    );
  }
}
