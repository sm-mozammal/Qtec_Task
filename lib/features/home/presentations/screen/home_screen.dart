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
import 'package:qtec_task/features/home/presentations/screen/widgets/show_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  Timer? _debounceTimer;

  @override
  void initState() {
    context.read<ProductBloc>().add(ProductFetchEvent());
    searchController.addListener(_sinkLatestValue);
    super.initState();
  }

  void _sinkLatestValue() {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      final searchText = searchController.text.trim();
      if (searchText.isNotEmpty) {
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      } else {
        context.read<ProductBloc>().add(ProductSearchEvent(searchText));
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 5,
                    child: CustomTextFormField(
                      isPrefixIcon: true,
                      iconpath: Assets.searchIcon,
                      hintText: 'Search Anything...',
                      controller: searchController,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () {
                            showSortByBottomSheet(context);
                          },
                          child: Icon(Icons.filter_list))),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is ProductLoadingState) {
                  return CircularProgressIndicator();
                } else if (state is ProductErrorState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is ProductFetchState) {
                  if (state.productResponse.products.isEmpty) {
                    return Center(
                      child: Text('No Product Found'),
                    );
                  }
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
                          discountPercentage:
                              product.discountPercentage?.toStringAsFixed(0),
                          discountPrice: (product.price! -
                                  (product.price! *
                                      product.discountPercentage! /
                                      100))
                              .toStringAsFixed(2),
                          rating: product.rating?.toStringAsFixed(1),
                          reviews: 100.toString(),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
            ],
          ),
        ),
      )),
    );
  }
}
