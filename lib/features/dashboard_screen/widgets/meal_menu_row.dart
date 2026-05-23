import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class MealMenuRow extends StatelessWidget {
  const MealMenuRow({
    super.key,
    required this.meal,
    required this.menu,
  });

  final String meal;
  final String menu;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        Flexible(
          flex: 2,
          child: Text(
            meal,
            style: CustomTextStyle.textSmSemiBold.copyWith(
              color: appTheme.black900,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            menu,
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black600,
            ),
          ),
        ),
      ],
    );
  }
}
