import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_task/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:qtec_task/features/home/data/models/product_list_model.dart';
import 'package:qtec_task/features/home/data/models/product_model.dart';
import 'package:qtec_task/features/home/data/repositories/product_repository_impl.dart';
import 'package:qtec_task/features/home/domain/uses_cases/get_produts.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_event.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  String errorMessage = 'Something Wants Wrong';
  ProductListModel? productResponse;
  ProductBloc() : super(ProductInitialState()) {
    on<ProductFetchEvent>(fetchProduct);
    on<ProductSearchEvent>(searchProduct);
  }

  Future<void> fetchProduct(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    try {
      ProductRemoteDataSource remoteDataSource = ProductRemoteDataSourceImpl();
      ProductRepositoryImpl todoRepository = ProductRepositoryImpl(
        remoteDataSource: remoteDataSource,
      );
      GetProducts getTodos = GetProducts(productRepositoy: todoRepository);

      ProductListModel response = await getTodos.call(1, 10);

      productResponse = response;
      emit(ProductFetchState(productResponse: response));
    } catch (e) {
      DioException error = e as DioException;
      if (error.type == DioExceptionType.connectionError) {
        errorMessage = "Check Your Network Connection";
      } else {
        errorMessage = error.response!.data["message"];
      }
      emit(ProductErrorState(errorMessage: errorMessage));
    }
  }

  Future<void> searchProduct(
      ProductSearchEvent event, Emitter<ProductState> emit) async {
    try {
      if (productResponse != null && productResponse!.products.isNotEmpty) {
        // filter from List<ProductModel>
        final filteredProducts = productResponse!.products.where((product) {
          return product.title
                  ?.toLowerCase()
                  .contains(event.queary.toLowerCase()) ??
              false;
        }).toList();

        final filteredProductModels = filteredProducts.cast<ProductModel>();

        // Create new ProductListModel with filtered results
        final filteredResponse = ProductListModel(
          products: filteredProductModels,
          total: filteredProducts.length,
          skip: 0,
          limit: filteredProducts.length,
        );

        emit(ProductFetchState(productResponse: filteredResponse));
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }
}
