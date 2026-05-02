import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/splash_screen/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(SplashInitial())
        ..add(SplashInitialEvent()),
      child: const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadSuccess) {
          // Navigate to walkthrough after splash
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.walkthroughScreen);
        }
      },
      child: Scaffold(
        backgroundColor: theme.primaryColor,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20.h,
            children: [
              CustomImageView(
                imagePath: "https://cdn-icons-png.flaticon.com/512/10044/10044101.png",
                height: 120.h,
                width: 120.w,
              ),
              Text(
                "lbl_hostel_hive".tr,
                style: CustomTextStyle.text3xlBold.copyWith(
                  color: appTheme.otherWhite,
                ),
              ),
              Text(
                "msg_stay_with_ease".tr,
                style: CustomTextStyle.textBaseMedium.copyWith(
                  color: appTheme.otherWhite.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
