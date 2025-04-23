import 'package:equatable/equatable.dart';
import 'package:qtec_task/features/home/data/models/product_list_model.dart';

class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductFetchState extends ProductState {
  final ProductListModel productResponse;

  const ProductFetchState({
    required this.productResponse,
  });

  @override
  List<Object?> get props => [productResponse];
}

class ProductSearchState extends ProductState {
  final ProductListModel productResponse;
  const ProductSearchState({required this.productResponse});

  @override
  List<Object?> get props => [
        productResponse,
      ];
}

class ProductErrorState extends ProductState {
  final String errorMessage;
  const ProductErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
