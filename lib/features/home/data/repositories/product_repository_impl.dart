import 'dart:developer';
import 'package:qtec_task/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:qtec_task/features/home/data/models/product_list_model.dart';
import 'package:qtec_task/features/home/domain/repositories/product_repositoy.dart';

class ProductRepositoryImpl implements ProductRepositoy {
  final ProductRemoteDataSource remoteDataSource;
  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ProductListModel> getProduct(int page, int limit) {
    return remoteDataSource.getProduct(page, limit).then((value) {
      return value;
    }).catchError((error) {
      log(error.toString());
      throw error;
    });
  }
}
