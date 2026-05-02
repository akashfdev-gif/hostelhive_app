import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/get_otp/bloc/get_otp_bloc.dart';

class GetOtpScreen extends StatelessWidget {
  const GetOtpScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<GetOtpBloc>(
      create: (context) => GetOtpBloc(),
      child: const GetOtpScreen(),
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
              _buildLogoSection(),
              SizedBox(height: 32.h),
              _buildWelcomeText(),
              SizedBox(height: 48.h),
              _buildPhoneInputSection(context),
              SizedBox(height: 40.h),
              _buildGetOtpButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: _buildFooterText(),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.red50,
        shape: BoxShape.circle,
      ),
      child: CustomImageView(
        imagePath: ImageConstant.imgGetOtp,
        height: 100.h,
        width: 100.w,
        radius: BorderRadius.circular(50.h),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CustomTextStyle.textXlBold.copyWith(
          color: appTheme.black900,
        ),
        children: [
          TextSpan(text: "msg_welcome_to".tr),
          TextSpan(
            text: "lbl_hostel_hive_auth".tr,
            style: TextStyle(color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneInputSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          "lbl_enter_phone".tr,
          style: CustomTextStyle.textBaseBold.copyWith(
            color: appTheme.black900,
          ),
        ),
        Row(
          spacing: 12.w,
          children: [
            BlocBuilder<GetOtpBloc, GetOtpState>(
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: appTheme.gray200),
                    borderRadius: BorderRadius.circular(8.h),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: state.selectedCountryCode,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: appTheme.gray500,
                        size: 20.h,
                      ),
                      style: CustomTextStyle.textBaseMedium.copyWith(
                        color: appTheme.gray700,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          context
                              .read<GetOtpBloc>()
                              .add(GetOtpCountryCodeChanged(countryCode: newValue));
                        }
                      },
                      items: <String>['+91', '+1', '+44', '+61']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: CustomTextFormFieldV2(
                hintText: "lbl_phone_number".tr,
                keyboard: TextInputType.phone,
                maxLength: 10,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Icon(Icons.phone_android, color: appTheme.gray500),
                prefixBoxConstraints: BoxConstraints(minWidth: 40.w),
                onChange: (value) {
                  context
                      .read<GetOtpBloc>()
                      .add(GetOtpPhoneNumberChanged(phoneNumber: value));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGetOtpButton() {
    return BlocBuilder<GetOtpBloc, GetOtpState>(
      builder: (context, state) {
        return CustomElevatedButton(
          text: "lbl_get_otp".tr,
          leftIcon: Icon(Icons.lock_outline, color: appTheme.otherWhite),
          buttonStyle: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 56.h),
            backgroundColor: state.isPhoneNumberValid
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.3),
            disabledBackgroundColor:
                theme.colorScheme.primary.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.h),
            ),
          ),
          onPressed: state.isPhoneNumberValid
              ? () {
                  context.read<GetOtpBloc>().add(GetOtpSubmitEvent());
                }
              : null,
        );
      },
    );
  }

  Widget _buildFooterText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: CustomTextStyle.textSmMedium.copyWith(
          color: appTheme.black900,
          height: 1.5,
        ),
        children: [
          TextSpan(text: "msg_by_proceeding".tr),
          TextSpan(
            text: "lbl_terms".tr,
            style: TextStyle(
              color: appTheme.blue900,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: "lbl_and".tr),
          TextSpan(
            text: "lbl_privacy".tr,
            style: TextStyle(
              color: appTheme.blue900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
