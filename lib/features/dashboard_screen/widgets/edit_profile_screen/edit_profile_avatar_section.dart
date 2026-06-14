part of 'edit_profile_screen.dart';

class _EditProfileAvatarSection extends StatelessWidget {
  const _EditProfileAvatarSection({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 12.h,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              NamedAvatar(
                name: name,
                radius: 52.h,
                fontSize: 32.fSize,
              ),
              Container(
                padding: EdgeInsets.all(6.h),
                decoration: BoxDecoration(
                  color: appTheme.red900,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: appTheme.otherWhite,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 16.h,
                  color: appTheme.otherWhite,
                ),
              ),
            ],
          ),
          Text(
            'msg_tap_to_change_photo'.tr,
            style: CustomTextStyle.textXsMedium.copyWith(
              color: appTheme.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
