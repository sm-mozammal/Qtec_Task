import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class ProductFetchEvent extends ProductEvent {
  final int page;
  final int limit;
  final bool isPagination;

  const ProductFetchEvent(
      {this.page = 1, this.limit = 20, this.isPagination = false});

  @override
  List<Object?> get props => [page, limit, isPagination];
}

class ProductSortEvent extends ProductEvent {
  final SortType sortType;
  const ProductSortEvent(this.sortType);

  @override
  List<Object?> get props => [sortType];
}

class ProductSearchEvent extends ProductEvent {
  final String queary;
  const ProductSearchEvent(this.queary);

  @override
  List<Object?> get props => [queary];
}

enum SortType { priceLowToHigh, priceHighToLow, rating }
