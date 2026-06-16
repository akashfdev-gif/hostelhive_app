import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_hive/core/models/complaint_model.dart';

part 'track_status_event.dart';
part 'track_status_state.dart';

class TrackStatusBloc extends Bloc<TrackStatusEvent, TrackStatusState> {
  TrackStatusBloc() : super(const TrackStatusState()) {
    on<LoadComplaintStatusEvent>(_onLoadComplaintStatus);
    on<DeleteComplaintEvent>(_onDeleteComplaint);
  }

  Future<void> _onDeleteComplaint(
    DeleteComplaintEvent event,
    Emitter<TrackStatusState> emit,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(event.complaintId)
          .delete();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onLoadComplaintStatus(
    LoadComplaintStatusEvent event,
    Emitter<TrackStatusState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await emit.forEach<QuerySnapshot<Map<String, dynamic>>>(
        FirebaseFirestore.instance
            .collection('complaints')
            .where('studentId', isEqualTo: uid)
            .snapshots(),
        onData: (querySnapshot) {
          final complaints = querySnapshot.docs
              .map((doc) => ComplaintModel.fromFirestore(doc))
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return state.copyWith(isLoading: false, complaints: complaints);
        },
        onError: (error, stackTrace) {
          return state.copyWith(
              isLoading: false, errorMessage: error.toString());
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
