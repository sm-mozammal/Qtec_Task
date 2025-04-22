import 'package:qtec_task/features/home/domain/entities/product_list.dart';

import 'product_model.dart';

class ProductListModel extends ProductList {
  ProductListModel({
    required List<ProductModel> super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      products: (json['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() => {
        'products': products.map((e) => (e as ProductModel).toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };
}
