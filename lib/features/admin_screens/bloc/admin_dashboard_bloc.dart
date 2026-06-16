import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_hive/core/models/complaint_model.dart';

part 'admin_dashboard_event.dart';
part 'admin_dashboard_state.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  AdminDashboardBloc()
      : super(const AdminDashboardState(selectedTab: AdminTab.home)) {
    on<AdminDashboardInitialEvent>(_onInitialEvent);
    on<AdminTabChangedEvent>(_onTabChangedEvent);
    on<UpdateComplaintStatusEvent>(_onUpdateComplaintStatus);
  }

  Future<void> _onInitialEvent(
    AdminDashboardInitialEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('complaints')
          .orderBy('createdAt', descending: true)
          .get();

      final complaints = querySnapshot.docs
          .map((doc) => ComplaintModel.fromFirestore(doc))
          .toList();

      emit(state.copyWith(isLoading: false, complaints: complaints));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onTabChangedEvent(
    AdminTabChangedEvent event,
    Emitter<AdminDashboardState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  Future<void> _onUpdateComplaintStatus(
    UpdateComplaintStatusEvent event,
    Emitter<AdminDashboardState> emit,
  ) async {
    try {
      final docRef = FirebaseFirestore.instance.collection('complaints').doc(event.complaintId);
      
      final Map<String, dynamic> updates = {
        'status': event.newStatus,
        'adminMessage': event.adminMessage,
      };

      final timestamp = Timestamp.now();
      switch (event.newStatus.toLowerCase()) {
        case 'received':
          updates['receivedAt'] = timestamp;
          break;
        case 'assigned':
          updates['assignedAt'] = timestamp;
          break;
        case 'in progress':
          updates['inProgressAt'] = timestamp;
          break;
        case 'resolved':
          updates['resolvedAt'] = timestamp;
          break;
      }

      await docRef.update(updates);

      // Re-fetch complaints
      add(AdminDashboardInitialEvent());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
