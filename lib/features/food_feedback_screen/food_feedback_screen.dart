import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/food_feedback_screen/bloc/food_feedback_bloc.dart';

class FoodFeedbackScreen extends StatelessWidget {
  const FoodFeedbackScreen({super.key});

  static const _mealTypes = [
    'lbl_breakfast',
    'lbl_lunch',
    'lbl_dinner',
  ];

  static Widget builder(BuildContext context) {
    final mealRating =
        ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    return BlocProvider<FoodFeedbackBloc>(
      create: (context) => FoodFeedbackBloc()
        ..add(FoodFeedbackInitialEvent(mealRating: mealRating)),
      child: const FoodFeedbackScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodFeedbackBloc, FoodFeedbackState>(
      listener: (context, state) {
        if (state.isSubmitted) {
          context.read<FoodFeedbackBloc>().add(FoodFeedbackResetSubmittedEvent());
          _showSubmittedPopup(context);
        }
      },
      child: CustomRoundedScreen(
        appBarTitle: 'lbl_food_feedback'.tr,
        scaffoldBackgroundColor: appTheme.blue900,
        appBarBackgroundColor: appTheme.blue900,
        bodyPadding: EdgeInsets.zero,
        body: BlocBuilder<FoodFeedbackBloc, FoodFeedbackState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20.h,
                children: [
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
                                context.read<FoodFeedbackBloc>().add(
                                      FoodFeedbackRatingChangedEvent(
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
                          state.mealRating > 0
                              ? '${state.mealRating}/5'
                              : 'msg_select_rating'.tr,
                          style: CustomTextStyle.textSmMedium.copyWith(
                            color: appTheme.black600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  DashboardSectionCard(
                    title: 'lbl_select_meal'.tr,
                    child: Row(
                      spacing: 10.w,
                      children: _mealTypes
                          .map(
                            (mealType) => Expanded(
                              child: _MealTypeChip(
                                label: mealType.tr,
                                isSelected:
                                    state.selectedMealType == mealType,
                                onTap: () {
                                  context.read<FoodFeedbackBloc>().add(
                                        FoodFeedbackMealTypeChangedEvent(
                                          mealType: mealType,
                                        ),
                                      );
                                },
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  DashboardSectionCard(
                    title: 'lbl_your_feedback'.tr,
                    child: CustomTextFormFieldV2(
                      hintText: 'lbl_feedback_hint'.tr,
                      maxLines: 5,
                      minLines: 4,
                      onChange: (value) {
                        context.read<FoodFeedbackBloc>().add(
                              FoodFeedbackTextChangedEvent(feedback: value),
                            );
                      },
                    ),
                  ),
                  CustomElevatedButton(
                    text: 'lbl_submit_feedback'.tr,
                    buttonStyle: CustomButtonStyle.primaryButtonTheme.copyWith(
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) {
                          if (states.contains(WidgetState.disabled)) {
                            return theme.colorScheme.primary
                                .withValues(alpha: 0.3);
                          }
                          return theme.colorScheme.primary;
                        },
                      ),
                    ),
                    onPressed: state.canSubmit
                        ? () {
                            context
                                .read<FoodFeedbackBloc>()
                                .add(FoodFeedbackSubmitEvent());
                          }
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSubmittedPopup(BuildContext context) {
    CustomAlertDialogV3.showAlertV3(
      context,
      content: 'msg_feedback_submitted'.tr,
      successButtonText: 'lbl_ok'.tr,
      barrierDismissible: true,
      onConfirmed: () {
        Navigator.of(context).pop();
        NavigatorService.goBack();
      },
    );
  }
}

class _MealTypeChip extends StatelessWidget {
  const _MealTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.h),
      child: Container(
        width: double.infinity,
        height: 48.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? appTheme.blue100 : appTheme.otherWhite,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(
            color: isSelected ? appTheme.blue700 : appTheme.otherBorder,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: CustomTextStyle.textSmMedium.copyWith(
              color: isSelected ? appTheme.blue900 : appTheme.black700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
