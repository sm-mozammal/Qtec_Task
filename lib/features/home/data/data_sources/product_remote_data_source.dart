import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:qtec_task/core/exception_handler/data_source.dart';
import 'package:qtec_task/core/services/networks/dio/dio.dart';
import 'package:qtec_task/core/services/networks/endpoints.dart';
import 'package:qtec_task/features/home/data/models/product_list_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductListModel> getProduct(int page, int limit);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<ProductListModel> getProduct(int page, int limit) async {
    try {
      Response response = await getHttp(Endpoints.product(page, limit));

      if (response.statusCode == 200) {
        return ProductListModel.fromJson(
            json.decode(json.encode(response.data)));
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
