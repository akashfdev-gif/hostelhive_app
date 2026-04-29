import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:book_store/v2/core/app_export.dart';
import 'package:book_store/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CustomRoundedScreen extends StatelessWidget {
  const CustomRoundedScreen(
      {super.key,
      required this.appBarTitle,
      required this.body,
      this.appBarActions,
      this.appBarLeading});
  final Widget body;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theme.primaryColor,
        appBar: CustomAppBar(
          title: appBarTitle,
          actions: appBarActions,
          leading: appBarLeading,
          toolbarHeight: 80.h,
        ),
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: appTheme.otherWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.h),
              topRight: Radius.circular(30.h),
            ),
          ),
          child: body,
        ));
  }
}
