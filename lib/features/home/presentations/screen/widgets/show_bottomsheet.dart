import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_bloc.dart';
import 'package:qtec_task/features/home/presentations/bloc/product_event.dart';

void showSortByBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sort By",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Price - High to Low"),
              onTap: () {
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.priceHighToLow));

                // Add sorting logic here
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Price - Low to High"),
              onTap: () {
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.priceLowToHigh));

                // Add sorting logic here
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text("Rating"),
              onTap: () {
                context
                    .read<ProductBloc>()
                    .add(ProductSortEvent(SortType.rating));

                // Add sorting logic here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
