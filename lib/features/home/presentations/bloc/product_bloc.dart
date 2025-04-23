import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_task/core/utils/toast.dart';
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
  int currentPage = 1;
  bool isLastPage = false;
  List<ProductModel> allProducts = [];
  bool isPaginating = false;

  ProductBloc() : super(ProductInitialState()) {
    on<ProductFetchEvent>(fetchProduct);
    on<ProductSearchEvent>(searchProduct);
    on<ProductSortEvent>(sortProduct);
  }

  Future<void> fetchProduct(
      ProductFetchEvent event, Emitter<ProductState> emit) async {
    if (event.isPagination) {
      // Avoid calling again if already paginating
      if (isPaginating || isLastPage) return;

      // Check if we are at the last page
      isPaginating = true;
      ToastUtil.showShortToast('Loading more products...');
    } else {
      // Resetting the state for a new fetch
      emit(ProductLoadingState());
      currentPage = 1;
      allProducts.clear();
      isLastPage = false;
    }

    try {
      // Check if we are at the last page
      ProductRemoteDataSource remoteDataSource = ProductRemoteDataSourceImpl();

      // Create a new instance of ProductRepositoryImpl
      ProductRepositoryImpl repository =
          ProductRepositoryImpl(remoteDataSource: remoteDataSource);

      // Create a new instance of GetProducts
      GetProducts getProducts = GetProducts(productRepositoy: repository);

      // Call the use case to fetch products
      final response = await getProducts.call(currentPage, event.limit);

      if (response.products.isEmpty) {
        // If no products are returned, set isLastPage to true
        isLastPage = true;
        ToastUtil.showLongToast('No more products available');
      } else {
        // Add the new products to the existing list
        allProducts.addAll(response.products.cast<ProductModel>());
        currentPage++;
      }

      // Create a new ProductListModel with the updated list of products
      productResponse = ProductListModel(
        products: allProducts,
        total: response.total,
        skip: 0,
        limit: allProducts.length,
      );

      // Emit the new state with the updated product list
      emit(ProductFetchState(
        productResponse: productResponse!,
      ));
      isPaginating = false;
    } catch (e) {
      DioException error = e as DioException;
      errorMessage = error.type == DioExceptionType.connectionError
          ? "Check Your Network Connection"
          : error.response?.data["message"] ?? "Something went wrong";
      emit(ProductErrorState(errorMessage: errorMessage));
      isPaginating = false;
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

        // Convert filtered products to List<ProductModel>
        final filteredProductModels = filteredProducts.cast<ProductModel>();

        // Create new ProductListModel with filtered results
        final filteredResponse = ProductListModel(
          products: filteredProductModels,
          total: filteredProducts.length,
          skip: 0,
          limit: filteredProducts.length,
        );

        // Emit the new state with the filtered product list
        emit(ProductFetchState(productResponse: filteredResponse));
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> sortProduct(
      ProductSortEvent event, Emitter<ProductState> emit) async {
    try {
      if (productResponse != null && productResponse!.products.isNotEmpty) {
        // Sort the products based on the selected sort type
        final products = List<ProductModel>.from(productResponse!.products);

        switch (event.sortType) {
          // Sort by priceLowToHigh:
          case SortType.priceLowToHigh:
            products.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
            break;

          // Sort by priceHighToLow:

          case SortType.priceHighToLow:
            products.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
            break;
          // Sort by rating:
          case SortType.rating:
            products.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
            break;
        }

        // Create new ProductListModel with sorted results

        final sortedResponse = ProductListModel(
          products: products,
          total: products.length,
          skip: 0,
          limit: products.length,
        );

        // Emit the new state with the sorted product list
        emit(ProductFetchState(productResponse: sortedResponse));
      }
    } catch (e) {
      emit(ProductErrorState(errorMessage: "Sorting failed: ${e.toString()}"));
    }
  }
}
