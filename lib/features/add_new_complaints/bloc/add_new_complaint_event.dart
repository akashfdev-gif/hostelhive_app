part of 'add_new_complaint_bloc.dart';

abstract class AddNewComplaintEvent extends Equatable {
  const AddNewComplaintEvent();

  @override
  List<Object?> get props => [];
}

class CategorySelectedEvent extends AddNewComplaintEvent {
  final String category;

  const CategorySelectedEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class TitleChangedEvent extends AddNewComplaintEvent {
  final String title;

  const TitleChangedEvent({required this.title});

  @override
  List<Object?> get props => [title];
}

class DescriptionChangedEvent extends AddNewComplaintEvent {
  final String description;

  const DescriptionChangedEvent({required this.description});

  @override
  List<Object?> get props => [description];
}

class PrioritySelectedEvent extends AddNewComplaintEvent {
  final String priority;

  const PrioritySelectedEvent({required this.priority});

  @override
  List<Object?> get props => [priority];
}

class ContactNumberChangedEvent extends AddNewComplaintEvent {
  final String contactNumber;

  const ContactNumberChangedEvent({required this.contactNumber});

  @override
  List<Object?> get props => [contactNumber];
}

class SubmitComplaintEvent extends AddNewComplaintEvent {}
