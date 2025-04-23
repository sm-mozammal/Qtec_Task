import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_bloc.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_event.dart';

void showSortByBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (_) {
      return Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sort By",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Price - High to Low"),
              onTap: () {
                // Add sorting logic here (Price High to Low)
                // Trigger the sorting event in the ProductBloc
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.priceHighToLow));

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Price - Low to High"),
              onTap: () {
                // Add sorting logic here (Price Low to High)
                // Trigger the sorting event in the ProductBloc
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.priceLowToHigh));

                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Rating"),
              onTap: () {
                // Add sorting logic here (Rating)
                // Trigger the sorting event in the ProductBloc
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.rating));

                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
