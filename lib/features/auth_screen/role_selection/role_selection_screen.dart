import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/auth_screen/role_selection/bloc/role_selection_bloc.dart';
import 'package:hostel_hive/features/auth_screen/sign_in/sign_in_screen.dart';
import 'package:hostel_hive/features/auth_screen/sign_up/sign_up_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => RoleSelectionBloc(),
      child: const RoleSelectionScreen(),
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
            spacing: 32.h,
            children: [
              CustomImageView(
                height: 250.h,
                width: double.infinity,
                imagePath: 'https://img.freepik.com/free-vector/college-students-with-books-flat-illustration_74855-5917.jpg',
              ),
              Column(
                spacing: 12.h,
                children: [
                  Text(
                    'lbl_choose_role'.tr,
                    style: CustomTextStyle.text3xlBold.copyWith(
                      color: appTheme.black900,
                    ),
                  ),
                  Text(
                    'Select your role to get started',
                    style: CustomTextStyle.textBaseMedium.copyWith(
                      color: appTheme.gray600,
                    ),
                  ),
                ],
              ),
              BlocBuilder<RoleSelectionBloc, RoleSelectionState>(
                builder: (context, state) {
                  return Column(
                    spacing: 16.h,
                    children: [
                      _buildRoleCard(
                        context: context,
                        role: 'student',
                        icon: Icons.school,
                        title: 'lbl_student'.tr,
                        subtitle: 'Access hostel, meals, complaints, and more',
                        isSelected: state.selectedRole == 'student',
                      ),
                      _buildRoleCard(
                        context: context,
                        role: 'admin',
                        icon: Icons.admin_panel_settings,
                        title: 'lbl_admin'.tr,
                        subtitle: 'Manage students, complaints, and hostel operations',
                        isSelected: state.selectedRole == 'admin',
                      ),
                    ],
                  );
                },
              ),
              BlocSelector<RoleSelectionBloc, RoleSelectionState, String?>(
                selector: (state) => state.selectedRole,
                builder: (context, selectedRole) {
                  return Column(
                    spacing: 12.h,
                    children: [
                      CustomElevatedButton(
                        text: 'lbl_sign_in'.tr,
                        height: 56.h,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        onPressed: selectedRole == null
                            ? null
                            : () {
                                NavigatorService.pushNamed(
                                  AppRoutes.signInScreen,
                                  arguments: selectedRole,
                                );
                              },
                      ),
                      if (selectedRole == 'student')
                        CustomElevatedButton(
                          text: 'lbl_sign_up'.tr,
                          textColor: appTheme.black900,
                          height: 56.h,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          buttonStyle: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(appTheme.otherWhite),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.h),
                              side: BorderSide(color: appTheme.black100),
                            )),
                          ),
                          onPressed: () {
                            NavigatorService.pushNamed(
                              AppRoutes.signUpScreen,
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String role,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<RoleSelectionBloc>().add(RoleSelectedEvent(role));
      },
      child: Container(
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.h),
          color: isSelected ? theme.primaryColor.withOpacity(0.1) : appTheme.otherWhite,
          border: Border.all(
            color: isSelected ? theme.primaryColor : appTheme.black100,
            width: 2,
          ),
        ),
        child: Row(
          spacing: 16.w,
          children: [
            Container(
              padding: EdgeInsets.all(12.h),
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : appTheme.gray200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: isSelected ? Colors.white : appTheme.gray700,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.textXlBold.copyWith(
                      color: appTheme.black900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: CustomTextStyle.textSmRegular.copyWith(
                      color: appTheme.gray600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
