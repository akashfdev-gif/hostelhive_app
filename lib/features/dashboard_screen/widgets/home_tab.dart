import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

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
              _WelcomeCard(),
              _TodaysMealsSection(),
              _QuickActionsSection(),
              _PendingPaymentsCard(),
              DashboardSectionCard(
                title: 'lbl_latest_notice'.tr,
                child: Text(
                  'msg_notice_preview'.tr,
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.black600,
                    height: 1.4,
                  ),
                ),
              ),
              DashboardSectionCard(
                title: 'lbl_complaint_status'.tr,
                trailing: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: appTheme.orange50,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Text(
                    'lbl_in_progress'.tr,
                    style: CustomTextStyle.textXsSemiBold.copyWith(
                      color: appTheme.orange900,
                    ),
                  ),
                ),
                child: Text(
                  'msg_complaint_preview'.tr,
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.black600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  Stream<Map<String, dynamic>> _studentDocStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) => (snap.data() ?? <String, dynamic>{}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appTheme.blue900, appTheme.blue700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: appTheme.cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16.w,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  'msg_welcome_back'.tr,
                  style: CustomTextStyle.textSmRegular.copyWith(
                    color: appTheme.otherWhite.withValues(alpha: 0.9),
                  ),
                ),
                StreamBuilder<Map<String, dynamic>>(
                  stream: _studentDocStream(),
                  builder: (context, snapshot) {
                    final name = snapshot.data?['name'] as String?;
                    final avatarName = name?.isNotEmpty == true
                        ? name!
                        : 'msg_student_name'.tr;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          avatarName,
                          style: CustomTextStyle.textXlBold.copyWith(
                            color: appTheme.otherWhite,
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                    );
                  },
                ),
                StreamBuilder<Map<String, dynamic>>(
                  stream: _studentDocStream(),
                  builder: (context, snapshot) {
                    final roomNumber = snapshot.data?['roomNumber'] as String?;
                    final block = snapshot.data?['block'] as String?;
                    final roomInfo = (roomNumber?.isNotEmpty ?? false) &&
                            (block?.isNotEmpty ?? false)
                        ? '${roomNumber!}, ${block!}'
                        : 'msg_room_info'.tr;
                    return Text(
                      roomInfo,
                      style: CustomTextStyle.textSmMedium.copyWith(
                        color: appTheme.blue100,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          StreamBuilder<Map<String, dynamic>>(
            stream: _studentDocStream(),
            builder: (context, snapshot) {
              final name = snapshot.data?['name'] as String?;
              final avatarName =
                  name?.isNotEmpty == true ? name! : 'msg_student_name'.tr;
              return NamedAvatar(
                name: avatarName,
                radius: 28.h,
                fontSize: 18.fSize,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TodaysMealsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      title: 'lbl_todays_meals'.tr,
      trailing: TextButton(
        onPressed: () {
          context.read<DashboardBloc>().add(
                DashboardQuickActionEvent(
                  action: DashboardQuickAction.viewMenu,
                ),
              );
        },
        child: Text(
          'lbl_view_menu'.tr,
          style: CustomTextStyle.textSmSemiBold.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      child: Row(
        spacing: 8.w,
        children: [
          Expanded(
            child: _MealChip(
              label: 'lbl_breakfast'.tr,
              icon: Icons.free_breakfast_outlined,
            ),
          ),
          Expanded(
            child: _MealChip(
              label: 'lbl_lunch'.tr,
              icon: Icons.lunch_dining_outlined,
            ),
          ),
          Expanded(
            child: _MealChip(
              label: 'lbl_dinner'.tr,
              icon: Icons.dinner_dining_outlined,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealChip extends StatelessWidget {
  const _MealChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.h,
      children: [
        Icon(icon, color: appTheme.blue700, size: 22.h),
        Text(
          label,
          style:
              CustomTextStyle.textXsMedium.copyWith(color: appTheme.black700),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _QuickActionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.h,
      children: [
        Text(
          'lbl_quick_actions'.tr,
          style: CustomTextStyle.textBaseSemiBold.copyWith(
            color: appTheme.black900,
          ),
        ),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            _QuickActionChip(
              label: 'lbl_raise_complaint'.tr,
              icon: Icons.report_problem_outlined,
              onTap: () => context.read<DashboardBloc>().add(
                    DashboardQuickActionEvent(
                      action: DashboardQuickAction.raiseComplaint,
                    ),
                  ),
            ),
            _QuickActionChip(
              label: 'lbl_pay_fees'.tr,
              icon: Icons.payment_outlined,
              onTap: () => context.read<DashboardBloc>().add(
                    DashboardQuickActionEvent(
                      action: DashboardQuickAction.payFees,
                    ),
                  ),
            ),
            _QuickActionChip(
              label: 'lbl_view_menu'.tr,
              icon: Icons.restaurant_menu_outlined,
              onTap: () => context.read<DashboardBloc>().add(
                    DashboardQuickActionEvent(
                      action: DashboardQuickAction.viewMenu,
                    ),
                  ),
            ),
            _QuickActionChip(
              label: 'lbl_contact_admin'.tr,
              icon: Icons.support_agent_outlined,
              onTap: () => context.read<DashboardBloc>().add(
                    DashboardQuickActionEvent(
                      action: DashboardQuickAction.contactAdmin,
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: appTheme.blueGrey50,
          borderRadius: BorderRadius.circular(10.h),
          border: Border.all(color: appTheme.otherBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.w,
          children: [
            Icon(icon, size: 18.h, color: appTheme.blue800),
            Text(
              label,
              style: CustomTextStyle.textSmMedium.copyWith(
                color: appTheme.blue900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingPaymentsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardSectionCard(
      title: 'lbl_pending_payments'.tr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Text(
            'msg_pending_amount'.tr,
            style: CustomTextStyle.textSmRegular.copyWith(
              color: appTheme.black600,
            ),
          ),
          CustomElevatedButton(
            text: 'lbl_pay_now'.tr,
            buttonStyle: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 44.h),
              backgroundColor: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
            ),
            onPressed: () {
              context.read<DashboardBloc>().add(
                    DashboardQuickActionEvent(
                      action: DashboardQuickAction.payFees,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
