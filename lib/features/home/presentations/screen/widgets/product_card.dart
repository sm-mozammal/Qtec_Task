import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qtec_task/core/constants/text_font_style.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imageUrl;
  final String? discountPrice;
  final String? discountPercentage;
  final String? rating;
  final String? reviews;

  const ProductCard(
      {super.key,
      required this.productName,
      required this.price,
      required this.imageUrl,
      this.discountPrice,
      this.discountPercentage,
      this.rating,
      this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 156.w,
          height: 164.h,
          decoration: ShapeDecoration(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: CachedNetworkImage(
            width: double.infinity,
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          productName,
          style: TextFontStyle.textStyle12Roboto400,
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              '\$$discountPrice',
              style: TextFontStyle.textStyle14Roboto400,
            ),
            SizedBox(width: 4.w),
            Text(
              '\$$price',
              style: TextFontStyle.textStyle10Roboto400UnderLine,
            ),
            SizedBox(width: 4.w),
            Text(
              '$discountPercentage% OFF',
              style: TextFontStyle.textStyle10Roboto400,
            )
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 12.sp),
            SizedBox(width: 4.w),
            Text(
              '$rating',
              style: TextFontStyle.textStyle10Roboto400,
            ),
            SizedBox(width: 4.w),
            Text(
              '($reviews reviews)',
              style: TextFontStyle.textStyle10Roboto400,
            )
          ],
        ),
      ],
    );
  }
}
