import 'package:qtec_task/features/home/data/models/product_list_model.dart';

abstract class ProductRepositoy {
  Future<ProductListModel> getProduct(int page, int limit);
}
