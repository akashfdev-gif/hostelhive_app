import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_hive/core/app_export.dart';

part 'add_new_complaint_event.dart';
part 'add_new_complaint_state.dart';

class AddNewComplaintBloc
    extends Bloc<AddNewComplaintEvent, AddNewComplaintState> {
  AddNewComplaintBloc() : super(const AddNewComplaintState()) {
    on<CategorySelectedEvent>(_onCategorySelected);
    on<TitleChangedEvent>(_onTitleChanged);
    on<DescriptionChangedEvent>(_onDescriptionChanged);
    on<PrioritySelectedEvent>(_onPrioritySelected);
    on<ContactNumberChangedEvent>(_onContactNumberChanged);
    on<SubmitComplaintEvent>(_onSubmitComplaint);
  }

  void _onCategorySelected(
    CategorySelectedEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
  }

  void _onTitleChanged(
    TitleChangedEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    DescriptionChangedEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onPrioritySelected(
    PrioritySelectedEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
    emit(state.copyWith(priority: event.priority));
  }

  void _onContactNumberChanged(
    ContactNumberChangedEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
    emit(state.copyWith(contactNumber: event.contactNumber));
  }

  Future<void> _onSubmitComplaint(
    SubmitComplaintEvent event,
    Emitter<AddNewComplaintState> emit,
  ) async {
    if (state.selectedCategory.isEmpty) {
      Fluttertoast.showToast(msg: "msg_select_category_validation".tr);
      return;
    }
    if (state.title.length < 5 || state.title.length > 50) {
      Fluttertoast.showToast(msg: 'msg_title_validation'.tr);
      return;
    }
    if (state.description.length < 20 || state.description.length > 500) {
      Fluttertoast.showToast(msg: 'msg_desc_validation'.tr);
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      await FirebaseFirestore.instance
          .collection('complaints')
          .add({
        'category': state.selectedCategory,
        'title': state.title,
        'description': state.description,
        'priority': state.priority,
        'contactNumber': state.contactNumber,
        'roomNumber': userDoc['roomNumber'] ?? '',
        'studentId': uid,
        'studentName': userDoc['name'] ?? '',
        'status': 'Pending',
        'adminMessage': '',
        'createdAt': Timestamp.now(),
        'receivedAt': null,
        'assignedAt': null,
        'inProgressAt': null,
        'resolvedAt': null,
      });

      emit(state.copyWith(isSubmitting: false));

      Fluttertoast.showToast(
        msg: "Complaint Submitted Successfully",
      );

      NavigatorService.goBack();
    } catch (e) {
      emit(state.copyWith(isSubmitting: false));

      Fluttertoast.showToast(
        msg: "Error: $e",
      );
    }
  }
}
