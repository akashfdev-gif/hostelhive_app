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

  void _onSubmitComplaint(
    SubmitComplaintEvent event,
    Emitter<AddNewComplaintState> emit,
  ) {
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
    // Simulate API submission
    Future.delayed(const Duration(seconds: 1), () {
      Fluttertoast.showToast(msg: "msg_complaint_submitted_success".tr);
      NavigatorService.goBack();
    });
  }
}
