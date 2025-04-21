// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qtec_task/core/constants/app_colors.dart';
import 'package:qtec_task/core/constants/text_font_style.dart';
import 'package:svg_flutter/svg.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isPrefixIcon;
  final AutovalidateMode? autovalidateMode;
  final double borderRadius;
  final VoidCallback? onSuffixIconTap;
  final String? iconpath;
  final FocusNode? focusNode;
  TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  List<TextInputFormatter>? inputFormatters;
  final int? maxLine;
  final bool? isReadOnly;
  final VoidCallback? onTap;

  CustomTextFormField(
      {super.key,
      this.labelText,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.borderRadius = 12.0, // Set to 10 pixels
      required this.isPrefixIcon,
      this.iconpath,
      this.onSuffixIconTap,
      this.focusNode,
      this.onFieldSubmitted,
      this.inputFormatters,
      this.textInputAction = TextInputAction.next,
      this.maxLine = 1,
      this.isReadOnly = false,
      this.onTap});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.isReadOnly ?? false,
        autovalidateMode: widget.autovalidateMode,
        focusNode: _focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction,
        maxLines: widget.maxLine,
        style: TextFontStyle.textStyle16Roboto400
            .copyWith(color: AppColors.c000000),
        cursorColor: AppColors.allPrimaryColor,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cFFFFFF,
            labelText: widget.labelText,
            hintText: widget.hintText,
            hintStyle: TextFontStyle.textStyle16Roboto400
                .copyWith(color: AppColors.c9CA3AF),
            prefixIcon: widget.isPrefixIcon
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, right: 12),
                    child: SvgPicture.asset(
                      widget.iconpath!,
                      width: 24,
                    ),
                  )
                : null,
            suffixIcon: widget.suffixIcon != null
                ? GestureDetector(
                    onTap: widget.onSuffixIconTap,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Icon(
                        widget.suffixIcon,
                        color: _isFocused
                            ? AppColors.allPrimaryColor
                            : AppColors.cD1D5DB,
                      ),
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(width: 1, color: AppColors.cD1D5DB),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(width: 1, color: AppColors.cD1D5DB),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                width: 1,
                color: AppColors
                    .allPrimaryColor, // Adjust the border width if needed
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(width: 1, color: AppColors.cD1D5DB),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(width: 1, color: AppColors.cD1D5DB),
            ),
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 8.h,
            )),
      ),
    );
  }
}
