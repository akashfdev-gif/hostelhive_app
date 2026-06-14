part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  const EditProfileState({
    this.isLoading = false,
    this.isSaving = false,
    this.isSaved = false,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.course = '',
    this.roomNumber = '',
    this.block = '',
    this.emergencyContact = '',
    this.parentName = '',
    this.errorMessage,
  });

  final bool isLoading;
  final bool isSaving;
  final bool isSaved;
  final String name;
  final String email;
  final String phone;
  final String course;
  final String roomNumber;
  final String block;
  final String emergencyContact;
  final String parentName;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        isLoading,
        isSaving,
        isSaved,
        name,
        email,
        phone,
        course,
        roomNumber,
        block,
        emergencyContact,
        parentName,
        errorMessage,
      ];

  EditProfileState copyWith({
    bool? isLoading,
    bool? isSaving,
    bool? isSaved,
    String? name,
    String? email,
    String? phone,
    String? course,
    String? roomNumber,
    String? block,
    String? emergencyContact,
    String? parentName,
    String? errorMessage,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      course: course ?? this.course,
      roomNumber: roomNumber ?? this.roomNumber,
      block: block ?? this.block,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      parentName: parentName ?? this.parentName,
      errorMessage: errorMessage,
    );
  }
}
