import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_hive/core/app_export.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/dashboard_section_card.dart';
import 'package:hostel_hive/features/dashboard_screen/widgets/edit_profile_screen/bloc/edit_profile_bloc.dart';

part 'edit_profile_form_section.dart';
part 'edit_profile_avatar_section.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileBloc()..add(EditProfileLoadEvent()),
      child: const EditProfileScreen(),
    );
  }

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _courseCtrl;
  late final TextEditingController _roomCtrl;
  late final TextEditingController _blockCtrl;
  late final TextEditingController _emergencyCtrl;
  late final TextEditingController _parentCtrl;

  bool _controllersInitialized = false;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _courseCtrl = TextEditingController();
    _roomCtrl = TextEditingController();
    _blockCtrl = TextEditingController();
    _emergencyCtrl = TextEditingController();
    _parentCtrl = TextEditingController();
  }

  void _fillControllers(EditProfileState state) {
    if (!_controllersInitialized && !state.isLoading) {
      _nameCtrl.text = state.name;
      _emailCtrl.text = state.email;
      _phoneCtrl.text = state.phone;
      _courseCtrl.text = state.course;
      _roomCtrl.text = state.roomNumber;
      _blockCtrl.text = state.block;
      _emergencyCtrl.text = state.emergencyContact;
      _parentCtrl.text = state.parentName;
      _controllersInitialized = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _courseCtrl.dispose();
    _roomCtrl.dispose();
    _blockCtrl.dispose();
    _emergencyCtrl.dispose();
    _parentCtrl.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditProfileBloc>().add(
            EditProfileSaveEvent(
              name: _nameCtrl.text.trim(),
              phone: _phoneCtrl.text.trim(),
              course: _courseCtrl.text.trim(),
              roomNumber: _roomCtrl.text.trim(),
              block: _blockCtrl.text.trim(),
              emergencyContact: _emergencyCtrl.text.trim(),
              parentName: _parentCtrl.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        _fillControllers(state);

        if (state.isSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('msg_profile_updated'.tr),
              backgroundColor: appTheme.green900,
              behavior: SnackBarBehavior.floating,
            ),
          );
          NavigatorService.goBack();
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: appTheme.red900,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.otherBackground,
        appBar: CustomAppBar(title: 'lbl_edit_profile'.tr),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20.h,
                  children: [
                    _EditProfileAvatarSection(name: _nameCtrl.text),
                    _EditProfileFormSection(
                      nameCtrl: _nameCtrl,
                      emailCtrl: _emailCtrl,
                      phoneCtrl: _phoneCtrl,
                      courseCtrl: _courseCtrl,
                      roomCtrl: _roomCtrl,
                      blockCtrl: _blockCtrl,
                      emergencyCtrl: _emergencyCtrl,
                      parentCtrl: _parentCtrl,
                    ),
                    CustomElevatedButton(
                      text: 'lbl_save_changes'.tr,
                      loading: state.isSaving,
                      buttonStyle: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 52.h),
                        backgroundColor: appTheme.red900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.h),
                        ),
                      ),
                      onPressed: () => _onSave(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
