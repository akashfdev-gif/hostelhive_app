part of 'track_status_bloc.dart';

abstract class TrackStatusEvent {
  const TrackStatusEvent();
}

class LoadComplaintStatusEvent extends TrackStatusEvent {
  const LoadComplaintStatusEvent();
}

class DeleteComplaintEvent extends TrackStatusEvent {
  final String complaintId;
  const DeleteComplaintEvent(this.complaintId);
}
