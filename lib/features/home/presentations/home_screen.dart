import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qtec_task/common/widgets/custom_textfiled.dart';
import 'package:qtec_task/core/constants/assets.dart';
import 'package:qtec_task/core/utils/ui_helpers.dart';
import 'package:qtec_task/features/home/presentations/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              CustomTextFormField(
                isPrefixIcon: true,
                iconpath: Assets.searchIcon,
                hintText: 'Search Anything...',
              ),
              UIHelper.verticalSpaceMedium,
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.6, // Width / Height ratio
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard();
                  })
            ],
          ),
        ),
      )),
    );
  }
}
