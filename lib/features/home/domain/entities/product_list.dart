import 'package:qtec_task/features/home/domain/entities/product.dart';

class ProductList {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductList({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
