import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomRoundedScreen extends StatelessWidget {
  const CustomRoundedScreen({
    super.key,
    required this.appBarTitle,
    required this.body,
    this.appBarActions,
    this.appBarLeading,
    this.scaffoldBackgroundColor,
    this.appBarBackgroundColor,
    this.bodyPadding,
  });

  final Widget body;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? appBarLeading;
  final Color? scaffoldBackgroundColor;
  final Color? appBarBackgroundColor;
  final EdgeInsetsGeometry? bodyPadding;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(30.h),
      topRight: Radius.circular(30.h),
    );

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor ?? appTheme.blue900,
      appBar: CustomAppBar(
        title: appBarTitle,
        actions: appBarActions,
        leading: appBarLeading,
        backgroundColor: appBarBackgroundColor ?? appTheme.blue900,
        toolbarHeight: 80.h,
        centerTitle: true,
      ),
      body: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding: bodyPadding ?? EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: appTheme.otherWhite,
            borderRadius: borderRadius,
          ),
          child: body,
        ),
      ),
    );
  }
}
