import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/meal_menu_row.dart';

class MealsTab extends StatelessWidget {
  const MealsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.h,
            children: [
              DashboardSectionCard(
                title: 'lbl_today_menu'.tr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: [
                    MealMenuRow(
                      meal: 'lbl_breakfast'.tr,
                      menu: 'msg_breakfast_menu'.tr,
                    ),
                    Divider(color: appTheme.gray200, height: 1),
                    MealMenuRow(
                      meal: 'lbl_lunch'.tr,
                      menu: 'msg_lunch_menu'.tr,
                    ),
                    Divider(color: appTheme.gray200, height: 1),
                    MealMenuRow(
                      meal: 'lbl_dinner'.tr,
                      menu: 'msg_dinner_menu'.tr,
                    ),
                  ],
                ),
              ),
              DashboardSectionCard(
                title: 'lbl_meal_timing'.tr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    _TimingRow(
                      icon: Icons.wb_sunny_outlined,
                      text: 'msg_breakfast_time'.tr,
                    ),
                    _TimingRow(
                      icon: Icons.light_mode_outlined,
                      text: 'msg_lunch_time'.tr,
                    ),
                    _TimingRow(
                      icon: Icons.nights_stay_outlined,
                      text: 'msg_dinner_time'.tr,
                    ),
                  ],
                ),
              ),
              DashboardSectionCard(
                title: 'lbl_meal_rating'.tr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    Row(
                      spacing: 4.w,
                      children: List.generate(5, (index) {
                        final rating = index + 1;
                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            context.read<DashboardBloc>().add(
                                  DashboardMealRatingChangedEvent(
                                    rating: rating,
                                  ),
                                );
                          },
                          icon: Icon(
                            rating <= state.mealRating
                                ? Icons.star
                                : Icons.star_border,
                            color: appTheme.otherYellow,
                            size: 32.h,
                          ),
                        );
                      }),
                    ),
                    Text(
                      '${state.mealRating}/5',
                      style: CustomTextStyle.textSmMedium.copyWith(
                        color: appTheme.black600,
                      ),
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: 'lbl_submit_feedback'.tr,
                buttonStyle: CustomButtonStyle.outlinedButtonTheme.copyWith(
                  foregroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.primary,
                  ),
                ),
                textColor: theme.colorScheme.primary,
                onPressed: () {},
              ),
              CustomElevatedButton(
                text: 'lbl_view_weekly'.tr,
                leftIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: appTheme.otherWhite,
                  size: 20.h,
                ),
                onPressed: () {
                  NavigatorService.pushNamed(AppRoutes.weeklyMenuScreen);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TimingRow extends StatelessWidget {
  const _TimingRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Icon(icon, color: appTheme.blue700, size: 20.h),
        Expanded(
          child: Text(
            text,
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black700,
            ),
          ),
        ),
      ],
    );
  }
}
