import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextFontStyle {
//Initialising Constractor
  TextFontStyle._();

  //All Text Font Style

  // Custom Text  Style

  static const textStyle16Roboto400 = TextStyle(
      fontFamily: 'Roboto',
      color: AppColors.c000000,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static const textStyle12Roboto400 = TextStyle(
    color: Color(0xFF1F2937),
    fontSize: 12,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    height: 1.50,
  );

  static const textStyle14Roboto400 = TextStyle(
    color: Color(0xFF1F2937),
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    height: 1.50,
    letterSpacing: 0.07,
  );

  static const textStyle10Roboto400UnderLine = TextStyle(
    color: Color(0xFF9CA3AF),
    fontSize: 10,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    height: 1.80,
  );

  static const textStyle10Roboto400 = TextStyle(
    color: Color(0xFFEA580C),
    fontSize: 10,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w500,
    height: 1.80,
  );
}
