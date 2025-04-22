import 'package:qtec_task/features/home/data/models/product_list_model.dart';
import 'package:qtec_task/features/home/domain/repositories/product_repositoy.dart';

class GetProducts {
  final ProductRepositoy productRepositoy;

  GetProducts({
    required this.productRepositoy,
  });

  Future<ProductListModel> call(int page, int limit) async {
    return await productRepositoy.getProduct(page, limit);
  }
}
