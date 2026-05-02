import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'bloc/walkthrough_bloc.dart';

class WalkthroughScreen extends StatelessWidget {
  const WalkthroughScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WalkthroughBloc>(
      create: (context) => WalkthroughBloc()..add(WalkthroughInitialEvent()),
      child: const WalkthroughScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalkthroughBloc, WalkthroughState>(
      listener: (context, state) {
        if (state.isNavigating) {
          NavigatorService.pushNamed(AppRoutes.homeScreen);
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.otherWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 32.h,
              children: [
                _buildImageSection(context),
                _buildTextSection(context),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomButton(context),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return CustomImageView(
      imagePath: "https://img.freepik.com/free-vector/hostel-concept-illustration_114360-9150.jpg",
      height: 300.h,
      width: double.infinity,
      radius: BorderRadius.circular(16.h),
      alignment: Alignment.center,
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "msg_find_your_home".tr,
                style: CustomTextStyle.text2xlBold.copyWith(
                  color: appTheme.blue700,
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "msg_discover_hostels".tr,
                style: CustomTextStyle.textBaseMedium.copyWith(
                  color: appTheme.gray700,
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: CustomTextStyle.textLgSemiBold.copyWith(
              color: appTheme.gray800,
            ),
            children: [
              TextSpan(
                text: "msg_safe".tr,
                style: TextStyle(color: appTheme.green700),
              ),
              TextSpan(
                text: " & ",
                style: TextStyle(color: appTheme.gray700),
              ),
              TextSpan(
                text: "msg_comfortable".tr,
                style: TextStyle(color: appTheme.orange900),
              ),
              TextSpan(text: "msg_stay_awaits".tr),
              TextSpan(
                text: "lbl_hostel_hive".tr,
                style: TextStyle(
                  color: appTheme.blue700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
      child: CustomElevatedButton(
        text: "lbl_get_started".tr,
        onPressed: () {
          context.read<WalkthroughBloc>().add(WalkthroughGetStartedEvent());
        },
      ),
    );
  }
}
