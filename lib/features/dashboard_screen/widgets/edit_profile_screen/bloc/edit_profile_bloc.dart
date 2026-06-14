import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(const EditProfileState()) {
    on<EditProfileLoadEvent>(_onLoad);
    on<EditProfileSaveEvent>(_onSave);
  }

  Future<void> _onLoad(
    EditProfileLoadEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        emit(state.copyWith(
          isLoading: false,
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          course: data['course'] ?? '',
          roomNumber: data['roomNumber'] ?? '',
          block: data['block'] ?? '',
          emergencyContact: data['emergencyContact'] ?? '',
          parentName: data['parentName'] ?? '',
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSave(
    EditProfileSaveEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, errorMessage: null, isSaved: false));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': event.name,
        'phone': event.phone,
        'course': event.course,
        'roomNumber': event.roomNumber,
        'block': event.block,
        'emergencyContact': event.emergencyContact,
        'parentName': event.parentName,
      });

      emit(state.copyWith(isSaving: false, isSaved: true));
    } catch (e) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
