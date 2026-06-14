part of 'edit_profile_screen.dart';

class _EditProfileFormSection extends StatelessWidget {
  const _EditProfileFormSection({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.courseCtrl,
    required this.roomCtrl,
    required this.blockCtrl,
    required this.emergencyCtrl,
    required this.parentCtrl,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController courseCtrl;
  final TextEditingController roomCtrl;
  final TextEditingController blockCtrl;
  final TextEditingController emergencyCtrl;
  final TextEditingController parentCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        DashboardSectionCard(
          title: 'lbl_personal_info'.tr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              _ProfileField(
                controller: nameCtrl,
                label: 'lbl_full_name'.tr,
                hint: 'hint_full_name'.tr,
                icon: Icons.person_outline,
                capitalization: TextCapitalization.words,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'err_name_required'.tr : null,
              ),
              _ProfileField(
                controller: emailCtrl,
                label: 'lbl_email'.tr,
                hint: 'hint_email'.tr,
                icon: Icons.email_outlined,
                readOnly: true,
                keyboard: TextInputType.emailAddress,
              ),
              _ProfileField(
                controller: phoneCtrl,
                label: 'lbl_phone'.tr,
                hint: 'hint_phone'.tr,
                icon: Icons.phone_outlined,
                keyboard: TextInputType.phone,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validator: (v) => (v == null || v.trim().length != 10)
                    ? 'err_phone_invalid'.tr
                    : null,
              ),
              _ProfileField(
                controller: courseCtrl,
                label: 'lbl_course'.tr,
                hint: 'hint_course'.tr,
                icon: Icons.school_outlined,
                capitalization: TextCapitalization.words,
              ),
            ],
          ),
        ),
        DashboardSectionCard(
          title: 'lbl_room_details'.tr,
          child: Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: _ProfileField(
                  controller: roomCtrl,
                  label: 'lbl_room_number'.tr,
                  hint: 'hint_room_number'.tr,
                  icon: Icons.meeting_room_outlined,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'err_room_required'.tr
                      : null,
                ),
              ),
              Expanded(
                child: _ProfileField(
                  controller: blockCtrl,
                  label: 'lbl_block'.tr,
                  hint: 'hint_block'.tr,
                  icon: Icons.apartment_outlined,
                  capitalization: TextCapitalization.characters,
                ),
              ),
            ],
          ),
        ),
        DashboardSectionCard(
          title: 'lbl_emergency_info'.tr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.h,
            children: [
              _ProfileField(
                controller: emergencyCtrl,
                label: 'lbl_emergency_contact'.tr,
                hint: 'hint_emergency_contact'.tr,
                icon: Icons.emergency_outlined,
                keyboard: TextInputType.phone,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                validator: (v) => (v != null && v.isNotEmpty && v.trim().length != 10)
                    ? 'err_phone_invalid'.tr
                    : null,
              ),
              _ProfileField(
                controller: parentCtrl,
                label: 'lbl_parent_name'.tr,
                hint: 'hint_parent_name'.tr,
                icon: Icons.family_restroom_outlined,
                capitalization: TextCapitalization.words,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Reusable Profile Field ──────────────────────────────────────────────────

class _ProfileField extends StatelessWidget {
  const _ProfileField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.readOnly = false,
    this.keyboard,
    this.validator,
    this.inputFormatter,
    this.maxLength,
    this.capitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool readOnly;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final int? maxLength;
  final TextCapitalization capitalization;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormFieldV2(
      controller: controller,
      labelText: label,
      labelLowercase: true,
      hintText: hint,
      readOnly: readOnly,
      keyboard: keyboard,
      validator: validator,
      inputFormatter: inputFormatter,
      maxLength: maxLength,
      capitalization: capitalization,
      validateMode: AutovalidateMode.onUserInteraction,
      fillColor:
          readOnly ? appTheme.gray100 : appTheme.otherWhite,
      prefixIcon: Icon(
        icon,
        size: 20.h,
        color: readOnly ? appTheme.gray500 : appTheme.blue700,
      ),
    );
  }
}
