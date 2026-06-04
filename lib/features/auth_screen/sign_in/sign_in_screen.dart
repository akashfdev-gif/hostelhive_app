import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/sign_in/bloc/sign_in_bloc.dart';
import 'package:hostel_hive/features/auth_screen/sign_up/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SignInBloc>(
      create: (context) => SignInBloc(),
      child: const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)?.settings.arguments as String?;
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (role == 'student') {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.dashboardScreen);
          } else {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.adminDashboardScreen);
          }
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.otherWhite,
        appBar: CustomAppBar(
          title: 'lbl_sign_in'.tr,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24.h,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      'lbl_sign_in'.tr,
                      style: CustomTextStyle.text3xlBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    Text(
                      'Welcome back! Please enter your details',
                      style: CustomTextStyle.textBaseMedium.copyWith(
                        color: appTheme.gray600,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return Column(
                      spacing: 16.h,
                      children: [
                        CustomTextFormFieldV2(
                          labelText: 'lbl_email'.tr,
                          hintText: 'Enter your email',
                          keyboard: TextInputType.emailAddress,
                          onChange: (val) {
                            context.read<SignInBloc>().add(SignInEmailChanged(val));
                          },
                        ),
                        CustomTextFormFieldV2(
                          labelText: 'lbl_password'.tr,
                          hintText: 'Enter your password',
                          obscureText: state.obscurePassword,
                          keyboard: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appTheme.gray500,
                            ),
                            onPressed: () {
                              context.read<SignInBloc>().add(
                                    const SignInTogglePasswordVisibilityEvent(),
                                  );
                            },
                          ),
                          onChange: (val) {
                            context.read<SignInBloc>().add(SignInPasswordChanged(val));
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'lbl_forgot_password'.tr,
                              style: CustomTextStyle.textSmMedium.copyWith(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      text: 'lbl_sign_in'.tr,
                      loading: state.isLoading,
                      height: 56.h,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      onPressed: !state.isFormValid
                          ? null
                          : () {
                              context.read<SignInBloc>().add(const SignInSubmitEvent());
                            },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'lbl_dont_have_account'.tr,
                      style: CustomTextStyle.textSmRegular.copyWith(
                        color: appTheme.gray700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (role == 'student') {
                          NavigatorService.pushNamed(AppRoutes.signUpScreen);
                        }
                      },
                      child: Text(
                        'lbl_sign_up'.tr,
                        style: CustomTextStyle.textSmMedium.copyWith(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
