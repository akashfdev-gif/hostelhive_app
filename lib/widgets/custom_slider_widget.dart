import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/custom_text_style.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:book_store/v2/core/app_export.dart';
import 'package:hostel_hive/core/utils/size_utils.dart';
import 'package:hostel_hive/themes/custom_text_style.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({
    super.key,
    required this.sliderTextHeading,
    required this.selectedInvestmentPeriod,
    required this.sliderStartingYear,
    required this.sliderEndingYear,
    required this.onChangedSelectedPeriod,
    this.min,
    this.max,
  });

  final String sliderTextHeading;
  final double selectedInvestmentPeriod;
  final String sliderStartingYear;
  final String sliderEndingYear;
  final Function(double) onChangedSelectedPeriod;
  final double? min;
  final double? max;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 103.h, //83.h
      child: Column(
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sliderTextHeader(
            textHead: sliderTextHeading.toUpperCase(),
            textTail:
                '${selectedInvestmentPeriod.toInt().toString()} ${'lbl_yrs'.tr}',
          ),
          _getCustomSlider(
            min: min ?? 1,
            max: max ?? 30,
            label: selectedInvestmentPeriod.toInt().toString(),
            value: selectedInvestmentPeriod,
            onChanged: onChangedSelectedPeriod,
          ),
          _sliderTextFooter(
            textHead: sliderStartingYear,
            textTail: sliderEndingYear,
          ),
        ],
      ),
    );
  }
}

SliderTheme _getCustomSlider(
    {required double value,
    final double? min,
    final double? max,
    final String? label,
    required Function(double) onChanged}) {
  return SliderTheme(
    data: SliderThemeData(
      padding: EdgeInsets.zero,
      trackHeight: 12.35.h,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.h),
      activeTrackColor: appTheme.blue500,
      inactiveTrackColor: appTheme.blue100,
      thumbColor: appTheme.gray150,
    ),
    child: Slider(
      value: value,
      min: min ?? 0.0,
      max: max ?? 1.0,
      label: label,
      onChanged: onChanged,
    ),
  );
}

SizedBox _sliderTextHeader({
  required String textHead,
  required String textTail,
}) {
  return SizedBox(
    height: 20.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _labelLargeText(text: textHead),
        Text(
          textTail,
          style: CustomTextStyle.textBaseMedium.copyWith(
            color: appTheme.black900,
          ),
        )
      ],
    ),
  );
}

SizedBox _sliderTextFooter({
  required String textHead,
  required String textTail,
}) {
  return SizedBox(
    height: 15.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _labelLargeText(text: textHead),
        _labelLargeText(text: textTail),
      ],
    ),
  );
}

Text _labelLargeText({required String text}) {
  return Text(
    text,
    style: CustomTextStyle.textXsMedium,
  );
}
