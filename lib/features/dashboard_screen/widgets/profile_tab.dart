import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/admin_contact_dialog.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String name = "";
  String email = "";
  String phone = "";
  String course = "";
  String roomNumber = "";
  String block = "";
  bool isLoading = true;

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
    return BlocListener<DashboardBloc, DashboardState>(
      listenWhen: (previous, current) =>
          !previous.showAdminContactDialog && current.showAdminContactDialog,
      listener: (context, state) {
        if (!state.showAdminContactDialog) return;

        showDialog<void>(
          context: context,
          builder: (context) => const AdminContactDialog(),
        );

        context
            .read<DashboardBloc>()
            .add(DashboardAdminContactDialogClosedEvent());
      },
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return StreamBuilder<Map<String, dynamic>>(
            stream: _studentDocStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data!;
              final nameVal = data['name'] as String? ?? '';
              final emailVal = data['email'] as String? ?? '';
              final phoneVal = data['phone'] as String? ?? '';
              final courseVal = data['course'] as String? ?? '';
              final roomNumberVal = data['roomNumber'] as String? ?? '';
              final blockVal = data['block'] as String? ?? '';

              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 20.h,
                  children: [
                    NamedAvatar(
                      name: nameVal,
                      radius: 40.h,
                      fontSize: 24.fSize,
                    ),
                    Text(
                      nameVal,
                      style: CustomTextStyle.textXlBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    Text(
                      'msg_room_info'.tr,
                      style: CustomTextStyle.textSmMedium.copyWith(
                        color: appTheme.gray600,
                      ),
                    ),
                    DashboardSectionCard(
                      title: 'lbl_student_details'.tr,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          _DetailRow(
                            icon: Icons.school_outlined,
                            label: 'lbl_course'.tr,
                            value: courseVal.isEmpty
                                ? 'msg_course_info'.tr
                                : courseVal,
                          ),
                          _DetailRow(
                            icon: Icons.email_outlined,
                            label: 'lbl_email'.tr,
                            value: emailVal,
                          ),
                          _DetailRow(
                            icon: Icons.phone_outlined,
                            label: 'lbl_phone'.tr,
                            value: phoneVal.isEmpty
                                ? 'msg_phone_info'.tr
                                : phoneVal,
                          ),
                        ],
                      ),
                    ),
                    DashboardSectionCard(
                      title: 'lbl_room_details'.tr,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          _DetailRow(
                            icon: Icons.meeting_room_outlined,
                            label: 'lbl_room_number'.tr,
                            value: roomNumberVal.isEmpty ? '--' : roomNumberVal,
                          ),
                          _DetailRow(
                            icon: Icons.apartment_outlined,
                            label: 'lbl_block'.tr,
                            value: blockVal.isEmpty ? '--' : blockVal,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'lbl_settings'.tr,
                      style: CustomTextStyle.textBaseSemiBold.copyWith(
                        color: appTheme.black900,
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'lbl_dark_mode'.tr,
                      trailing: Switch(
                        value: state.isDarkModeEnabled,
                        activeThumbColor: theme.colorScheme.primary,
                        onChanged: (_) {
                          context
                              .read<DashboardBloc>()
                              .add(DashboardDarkModeToggledEvent());
                        },
                      ),
                    ),
                    _SettingsTile(
                      icon: Icons.edit_outlined,
                      title: 'lbl_edit_profile'.tr,
                      onTap: () async {
                        await NavigatorService.pushNamed(
                          AppRoutes.editProfileScreen,
                        );
                        // No manual reload needed; Firestore stream updates automatically.
                      },
                    ),
                    _SettingsTile(
                      icon: Icons.support_agent_outlined,
                      title: 'lbl_contact_admin'.tr,
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => const AdminContactDialog(),
                        );
                      },
                    ),
                    CustomElevatedButton(
                      text: 'lbl_logout'.tr,
                      buttonStyle: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        backgroundColor: appTheme.red50,
                        foregroundColor: theme.colorScheme.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.h),
                          side: BorderSide(color: theme.colorScheme.primary),
                        ),
                      ),
                      textColor: theme.colorScheme.primary,
                      onPressed: () {
                        NavigatorService.pushNamedAndRemoveUntil(
                          AppRoutes.walkthroughScreen,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.w,
      children: [
        Icon(icon, size: 20.h, color: appTheme.blue700),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2.h,
            children: [
              Text(
                label,
                style: CustomTextStyle.textXsMedium.copyWith(
                  color: appTheme.gray600,
                ),
              ),
              Text(
                value,
                style: CustomTextStyle.textSmRegular.copyWith(
                  color: appTheme.black800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appTheme.otherWhite,
      borderRadius: BorderRadius.circular(10.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            border: Border.all(color: appTheme.otherBorder),
          ),
          child: Row(
            spacing: 12.w,
            children: [
              Icon(icon, color: appTheme.blue800, size: 22.h),
              Expanded(
                child: Text(
                  title,
                  style: CustomTextStyle.textBaseMedium.copyWith(
                    color: appTheme.black900,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
