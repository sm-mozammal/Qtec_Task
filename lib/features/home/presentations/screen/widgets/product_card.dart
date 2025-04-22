import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qtec_task/core/constants/text_font_style.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imageUrl;
  const ProductCard(
      {super.key,
      required this.productName,
      required this.price,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 156,
          height: 164,
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
        const SizedBox(height: 8),
        Text(
          productName,
          style: TextFontStyle.textStyle12Roboto400,
        ),
        const SizedBox(height: 4),
        Text(
          '\$$price',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
