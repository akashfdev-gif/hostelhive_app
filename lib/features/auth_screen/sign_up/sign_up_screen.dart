import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/sign_up/bloc/sign_up_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: const SignUpScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isSuccess) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.dashboardScreen);
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.otherWhite,
        appBar: CustomAppBar(
          title: 'lbl_sign_up'.tr,
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
                      'lbl_sign_up'.tr,
                      style: CustomTextStyle.text3xlBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    Text(
                      'Create an account to get started',
                      style: CustomTextStyle.textBaseMedium.copyWith(
                        color: appTheme.gray600,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return Column(
                      spacing: 16.h,
                      children: [
                        CustomTextFormFieldV2(
                          labelText: 'lbl_email'.tr,
                          hintText: 'Enter your email',
                          keyboard: TextInputType.emailAddress,
                          onChange: (val) {
                            context.read<SignUpBloc>().add(SignUpEmailChanged(val));
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
                              context.read<SignUpBloc>().add(
                                    const SignUpTogglePasswordVisibilityEvent(),
                                  );
                            },
                          ),
                          onChange: (val) {
                            context.read<SignUpBloc>().add(SignUpPasswordChanged(val));
                          },
                        ),
                        CustomTextFormFieldV2(
                          labelText: 'lbl_confirm_password'.tr,
                          hintText: 'Confirm your password',
                          obscureText: state.obscureConfirmPassword,
                          keyboard: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: appTheme.gray500,
                            ),
                            onPressed: () {
                              context.read<SignUpBloc>().add(
                                    const SignUpToggleConfirmPasswordVisibilityEvent(),
                                  );
                            },
                          ),
                          onChange: (val) {
                            context.read<SignUpBloc>().add(SignUpConfirmPasswordChanged(val));
                          },
                        ),
                        if (state.errorMessage != null)
                          Text(
                            state.errorMessage!.tr,
                            style: CustomTextStyle.textSmRegular.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return CustomElevatedButton(
                      text: 'lbl_sign_up'.tr,
                      loading: state.isLoading,
                      height: 56.h,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      onPressed: !state.isFormValid
                          ? null
                          : () {
                              context.read<SignUpBloc>().add(const SignUpSubmitEvent());
                            },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'lbl_already_have_account'.tr,
                      style: CustomTextStyle.textSmRegular.copyWith(
                        color: appTheme.gray700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigatorService.pushNamed(AppRoutes.signInScreen, arguments: 'student');
                      },
                      child: Text(
                        'lbl_sign_in'.tr,
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
