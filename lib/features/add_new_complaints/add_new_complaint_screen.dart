import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/add_new_complaints/bloc/add_new_complaint_bloc.dart';

class AddNewComplaintScreen extends StatelessWidget {
  const AddNewComplaintScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<AddNewComplaintBloc>(
      create: (context) => AddNewComplaintBloc(),
      child: const AddNewComplaintScreen(),
    );
  }

  static const _categories = [
    'lbl_cat_electricity',
    'lbl_cat_water',
    'lbl_cat_wifi',
    'lbl_cat_cleaning',
    'lbl_cat_food',
    'lbl_cat_bathroom',
    'lbl_cat_room_maintenance',
    'lbl_cat_security',
    'lbl_cat_other',
  ];

  static const _priorities = [
    'lbl_high',
    'lbl_medium',
    'lbl_low',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewComplaintBloc, AddNewComplaintState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: appTheme.otherBackground,
          appBar: CustomAppBar(
            title: 'lbl_add_new_complaint'.tr,
            centerTitle: true,
            backgroundColor: appTheme.blue900,
            toolbarHeight: 64.h,
            actions: [
              IconButton(
                icon: Icon(Icons.help_outline, color: appTheme.otherWhite),
                onPressed: () {
                  // Show help info
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: [
                _buildFieldLabel('lbl_complaint_category_req'.tr),
                CustomDropdownSelect(
                  options: _categories.map((c) => c.tr).toList(),
                  labelText: null,
                  initialValue: state.selectedCategory.isEmpty
                      ? 'lbl_select_category'.tr
                      : state.selectedCategory.tr,
                  onChange: (value) {
                    final key = _categories.firstWhere(
                        (k) => k.tr == value,
                        orElse: () => value);
                    context
                        .read<AddNewComplaintBloc>()
                        .add(CategorySelectedEvent(category: key));
                  },
                ),
                _buildFieldLabel('lbl_complaint_title'.tr),
                CustomTextFormFieldV2(
                  hintText: 'lbl_enter_title'.tr,
                  maxLength: 50,
                  textStyle: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black900),
                  onChange: (value) {
                    context
                        .read<AddNewComplaintBloc>()
                        .add(TitleChangedEvent(title: value));
                  },
                ),
                _buildFieldLabel('lbl_complaint_description'.tr),
                CustomTextFormFieldV2(
                  hintText: 'lbl_enter_description'.tr,
                  maxLength: 500,
                  maxLines: 5,
                  minLines: 5,
                  textStyle: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black900),
                  onChange: (value) {
                    context
                        .read<AddNewComplaintBloc>()
                        .add(DescriptionChangedEvent(description: value));
                  },
                ),
                _buildFieldLabel('lbl_priority_level_opt'.tr),
                Row(
                  spacing: 12.w,
                  children: _priorities.map((priorityKey) {
                    final isSelected = state.priority == priorityKey;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<AddNewComplaintBloc>()
                              .add(PrioritySelectedEvent(priority: priorityKey));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? appTheme.blue500.withValues(alpha: 0.1)
                                : appTheme.otherWhite,
                            borderRadius: BorderRadius.circular(8.h),
                            border: Border.all(
                              color: isSelected
                                  ? appTheme.blue500
                                  : appTheme.otherBorder,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            priorityKey.tr,
                            style: CustomTextStyle.textSmMedium.copyWith(
                              color: isSelected
                                  ? appTheme.blue500
                                  : appTheme.black800,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                _buildFieldLabel('lbl_room_number'.tr),
                CustomTextFormFieldV2(
                  initialValue: state.roomNumber,
                  readOnly: true,
                  fillColor: appTheme.gray100,
                  textStyle: CustomTextStyle.textSmMedium
                      .copyWith(color: appTheme.black600),
                ),
                _buildFieldLabel('lbl_date_time'.tr),
                CustomTextFormFieldV2(
                  initialValue: DateTime.now().format(pattern: 'dd MMMM yyyy, hh:mm a'),
                  readOnly: true,
                  fillColor: appTheme.gray100,
                  textStyle: CustomTextStyle.textSmMedium
                      .copyWith(color: appTheme.black600),
                ),
                _buildFieldLabel('lbl_contact_number'.tr),
                CustomTextFormFieldV2(
                  initialValue: state.contactNumber,
                  keyboard: TextInputType.phone,
                  textStyle: CustomTextStyle.textSmRegular
                      .copyWith(color: appTheme.black900),
                  onChange: (value) {
                    context
                        .read<AddNewComplaintBloc>()
                        .add(ContactNumberChangedEvent(contactNumber: value));
                  },
                ),
                SizedBox(height: 10.h),
                CustomElevatedButton(
                  text: 'lbl_submit_complaint'.tr,
                  loading: state.isSubmitting,
                  onPressed: () {
                    context
                        .read<AddNewComplaintBloc>()
                        .add(SubmitComplaintEvent());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Text(
        label,
        style: CustomTextStyle.textSmMedium.copyWith(
          color: appTheme.black800,
        ),
      ),
    );
  }
}
