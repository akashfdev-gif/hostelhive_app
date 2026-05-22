import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/successful_screen/bloc/successful_bloc.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SuccessfulBloc>(
      create: (context) => SuccessfulBloc(),
      child: const SuccessfulScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.otherWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CustomImageView(
                imagePath: ImageConstant.imgSuccessful,
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 48.h),
              Text(
                "lbl_congratulations".tr,
                style: CustomTextStyle.text2xlSemiBold.copyWith(
                  color: appTheme.black900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                "msg_youve_been_onboarded".tr,
                style: CustomTextStyle.text2xlSemiBold.copyWith(
                  color: appTheme.black900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "msg_dive_into_world".tr,
                style: CustomTextStyle.textXlRegular.copyWith(
                  color: appTheme.black500,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
          child: BlocBuilder<SuccessfulBloc, SuccessfulState>(
            builder: (context, state) {
              return CustomElevatedButton(
                text: "lbl_continue".tr,
                leftIcon: Icon(
                  Icons.keyboard_double_arrow_right,
                  color: appTheme.otherWhite,
                ),
                buttonStyle: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                ),
                onPressed: () {
                  context.read<SuccessfulBloc>().add(SuccessfulContinueEvent());
                  NavigatorService.pushNamedAndRemoveUntil(
                      AppRoutes.dashboardScreen);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
