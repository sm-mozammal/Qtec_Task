import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qtec_task/common/widgets/custom_textfiled.dart';
import 'package:qtec_task/core/constants/assets.dart';
import 'package:qtec_task/core/utils/ui_helpers.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_bloc.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_event.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_state.dart';
import 'package:qtec_task/features/home/presentations/screen/widgets/product_card.dart';
import 'package:qtec_task/features/home/presentations/screen/widgets/shimmer.dart';
import 'package:qtec_task/features/home/presentations/screen/widgets/show_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounceTimer;

  @override
  void initState() {
    context.read<ProductBloc>().add(ProductFetchEvent());
    searchController.addListener(_sinkLatestValue);
    _scrollController.addListener(_sinkScrool);
    super.initState();
  }

  void _sinkScrool() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      // Trigger next page
      context.read<ProductBloc>().add(ProductFetchEvent(
            page: 0, // page is handled in bloc
            limit: 20,
            isPagination: true,
          ));
    }
  }

  void _sinkLatestValue() {
    _debounceTimer?.cancel();

    // Debounce the search input
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      final searchText = searchController.text.trim();
      if (searchText.isNotEmpty) {
        // Trigger search event with the latest value
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      } else {
        // If the search text is empty, fetch all products
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Search bar
                  Flexible(
                    flex: 5,
                    child: CustomTextFormField(
                      isPrefixIcon: true,
                      iconpath: Assets.searchIcon,
                      hintText: 'Search Anything...',
                      controller: searchController,
                    ),
                  ),
                  // Filter icon
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            // Show sort by bottom sheet
                            showSortByBottomSheet(context);
                          },
                          child: Icon(Icons.filter_list))),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is ProductLoadingState) {
                  // Show loading state with shimmer effect
                  return ProductCardShimmer();
                } else if (state is ProductErrorState) {
                  // Handle error state and show error message
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ProductFetchState) {
                  // Check if the products are empty and show a message
                  if (state.productResponse.products.isEmpty) {
                    return Center(
                      child: Text('No Product Found'),
                    );
                  }

                  // All Products are loaded
                  return _buildProductList(state);
                } else {
                  // Default case, show shimmer effect
                  return ProductCardShimmer();
                }
              }),
            ],
          ),
        ),
      )),
    );
  }

  GridView _buildProductList(ProductFetchState state) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.productResponse.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.58, // Width / Height ratio
        ),
        itemBuilder: (context, index) {
          final product = state.productResponse.products[index];
          return ProductCard(
            price: product.price!.toStringAsFixed(2),
            productName: product.title!,
            imageUrl: product.images!.first,
            discountPercentage: product.discountPercentage?.toStringAsFixed(0),
            discountPrice: (product.price! -
                    (product.price! * product.discountPercentage! / 100))
                .toStringAsFixed(2),
            rating: product.rating?.toStringAsFixed(1),
            reviews: product.reviews?.length.toString() ?? '0',
          );
        });
  }
}
