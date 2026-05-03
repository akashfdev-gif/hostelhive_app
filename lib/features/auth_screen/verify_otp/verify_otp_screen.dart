import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/verify_otp/bloc/verify_otp_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<VerifyOtpBloc>(
      create: (context) => VerifyOtpBloc(),
      child: const VerifyOtpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.otherWhite,
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Colors.transparent,
        iconColor: appTheme.black900,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLogoSection(),
              SizedBox(height: 32.h),
              Text(
                "lbl_otp_verification".tr,
                style: CustomTextStyle.textXlBold.copyWith(
                  color: appTheme.black900,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "msg_otp_sent".tr,
                style: CustomTextStyle.textBaseMedium.copyWith(
                  color: appTheme.gray500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              _buildOtpInput(context),
              SizedBox(height: 32.h),
              _buildResendTimer(context),
              SizedBox(height: 40.h),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.blueGrey50,
        shape: BoxShape.circle,
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgGetOtp,
        height: 100.h,
        width: 100.h,
        radius: BorderRadius.circular(50.h),
      ),
    );
  }

  Widget _buildOtpInput(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
      textStyle: CustomTextStyle.textXlBold.copyWith(
        color: appTheme.black900,
      ),
      decoration: BoxDecoration(
        color: appTheme.gray100,
        borderRadius: BorderRadius.circular(8.h),
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: theme.colorScheme.primary),
        color: appTheme.otherWhite,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: appTheme.otherWhite,
        border: Border.all(color: theme.colorScheme.primary),
      ),
    );

    return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
      builder: (context, state) {
        return Pinput(
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          showCursor: true,
          onChanged: (value) {
            context
                .read<VerifyOtpBloc>()
                .add(VerifyOtpCodeChanged(otpCode: value));
          },
        );
      },
    );
  }

  Widget _buildResendTimer(BuildContext context) {
    return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
      builder: (context, state) {
        if (state.timerDuration > 0) {
          return RichText(
            text: TextSpan(
              style: CustomTextStyle.textSmMedium.copyWith(
                color: appTheme.black900,
              ),
              children: [
                TextSpan(text: "msg_didnt_receive_code".tr),
                TextSpan(
                  text:
                      "${"lbl_resend_in".tr}00:${state.timerDuration.toString().padLeft(2, '0')}${"lbl_sec".tr}",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        return GestureDetector(
          onTap: () {
            context.read<VerifyOtpBloc>().add(VerifyOtpResendEvent());
          },
          child: RichText(
            text: TextSpan(
              style: CustomTextStyle.textSmMedium.copyWith(
                color: appTheme.black900,
              ),
              children: [
                TextSpan(text: "msg_didnt_receive_code".tr),
                TextSpan(
                  text: "lbl_resend".tr,
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerifyButton() {
    return BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
      builder: (context, state) {
        return CustomElevatedButton(
          text: "lbl_verify_otp".tr,
          leftIcon: Icon(Icons.verified, color: appTheme.otherWhite),
          buttonStyle: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 56.h),
            backgroundColor: state.isOtpValid
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.2),
            disabledBackgroundColor:
                theme.colorScheme.primary.withValues(alpha: 0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.h),
            ),
          ),
          onPressed: state.isOtpValid
              ? () {
                  context.read<VerifyOtpBloc>().add(VerifyOtpSubmitEvent());
                  NavigatorService.pushNamed(AppRoutes.successfulScreen);
                }
              : null,
        );
      },
    );
  }
}
