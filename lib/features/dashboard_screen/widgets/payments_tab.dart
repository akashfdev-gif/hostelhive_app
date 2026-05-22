import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';

class PaymentsTab extends StatelessWidget {
  const PaymentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20.h,
        children: [
          DashboardSectionCard(
            title: 'lbl_pending_fees'.tr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                Text(
                  'lbl_hostel_fee'.tr,
                  style: CustomTextStyle.textSmSemiBold.copyWith(
                    color: appTheme.black900,
                  ),
                ),
                Text(
                  'msg_amount_due'.tr,
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.black600,
                  ),
                ),
                Text(
                  'msg_pending_amount'.tr,
                  style: CustomTextStyle.textLgBold.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                CustomElevatedButton(
                  text: 'lbl_online_payment'.tr,
                  leftIcon: Icon(
                    Icons.payment,
                    color: appTheme.otherWhite,
                    size: 20.h,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          DashboardSectionCard(
            title: 'lbl_payment_history'.tr,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
              children: [
                Icon(
                  Icons.history,
                  color: appTheme.green700,
                  size: 22.h,
                ),
                Expanded(
                  child: Text(
                    'msg_last_payment'.tr,
                    style: CustomTextStyle.textSmRegular.copyWith(
                      color: appTheme.black700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            text: 'lbl_download_receipt'.tr,
            buttonStyle: CustomButtonStyle.outlinedButtonTheme,
            textColor: theme.colorScheme.primary,
            leftIcon: Icon(
              Icons.download_outlined,
              color: theme.colorScheme.primary,
              size: 20.h,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
