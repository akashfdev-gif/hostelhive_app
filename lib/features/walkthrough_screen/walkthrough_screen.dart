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
          NavigatorService.pushNamed(AppRoutes.roleSelectionScreen);
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
      imagePath:
          "https://img.freepik.com/free-vector/hostel-concept-illustration_114360-9150.jpg",
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
        Text(
          "msg_walkthrough_title".tr,
          textAlign: TextAlign.center,
          style: CustomTextStyle.text2xlBold.copyWith(
            color: appTheme.black900,
            height: 1.2,
          ),
        ),
        Text(
          "msg_walkthrough_desc".tr,
          textAlign: TextAlign.center,
          style: CustomTextStyle.textBaseMedium.copyWith(
            color: appTheme.gray600,
            height: 1.5,
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
