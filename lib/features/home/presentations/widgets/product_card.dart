import 'package:flutter/material.dart';
import 'package:qtec_task/core/constants/assets.dart';
import 'package:qtec_task/core/constants/text_font_style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

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
          child: Image.asset(
            Assets.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Allen Solly Regular fit cotton shirt',
          style: TextFontStyle.textStyle12Roboto400,
        ),
        const SizedBox(height: 4),
        const Text(
          '\$99.99',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
