import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/sign_in/bloc/sign_in_bloc.dart';

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
    final role =
        ModalRoute.of(context)?.settings.arguments as String? ?? 'student';
    final isAdmin = role == 'admin';
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isSuccess) {
          if (isAdmin) {
            NavigatorService.pushNamedAndRemoveUntil(
                AppRoutes.adminDashboardScreen);
          } else {
            NavigatorService.pushNamedAndRemoveUntil(AppRoutes.dashboardScreen);
          }
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.otherWhite,
        appBar: CustomAppBar(
          title: isAdmin ? 'Admin Sign In' : 'Student Sign In',
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
                      isAdmin ? 'Admin Sign In' : 'Student Sign In',
                      style: CustomTextStyle.text3xlBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    Text(
                      isAdmin
                          ? 'Enter admin credentials to continue.'
                          : 'Welcome back! Please enter your details',
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
                            context
                                .read<SignInBloc>()
                                .add(SignInEmailChanged(val));
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
                            context
                                .read<SignInBloc>()
                                .add(SignInPasswordChanged(val));
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
                              context
                                  .read<SignInBloc>()
                                  .add(const SignInSubmitEvent());
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
                        NavigatorService.pushNamed(
                          AppRoutes.signUpScreen,
                          arguments: role,
                        );
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
