part of 'add_new_complaint_bloc.dart';

class AddNewComplaintState extends Equatable {
  const AddNewComplaintState({
    this.selectedCategory = '',
    this.title = '',
    this.description = '',
    this.priority = 'lbl_medium',
    this.roomNumber = 'Room 203',
    this.contactNumber = '+91 98765 43210',
    this.isSubmitting = false,
  });

  final String selectedCategory;
  final String title;
  final String description;
  final String priority;
  final String roomNumber;
  final String contactNumber;
  final bool isSubmitting;

  AddNewComplaintState copyWith({
    String? selectedCategory,
    String? title,
    String? description,
    String? priority,
    String? roomNumber,
    String? contactNumber,
    bool? isSubmitting,
  }) {
    return AddNewComplaintState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      roomNumber: roomNumber ?? this.roomNumber,
      contactNumber: contactNumber ?? this.contactNumber,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategory,
        title,
        description,
        priority,
        roomNumber,
        contactNumber,
        isSubmitting,
      ];
}
