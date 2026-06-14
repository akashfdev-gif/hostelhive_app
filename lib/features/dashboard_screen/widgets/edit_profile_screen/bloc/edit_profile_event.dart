part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class EditProfileLoadEvent extends EditProfileEvent {}

class EditProfileSaveEvent extends EditProfileEvent {
  EditProfileSaveEvent({
    required this.name,
    required this.phone,
    required this.course,
    required this.roomNumber,
    required this.block,
    required this.emergencyContact,
    required this.parentName,
  });

  final String name;
  final String phone;
  final String course;
  final String roomNumber;
  final String block;
  final String emergencyContact;
  final String parentName;
}
