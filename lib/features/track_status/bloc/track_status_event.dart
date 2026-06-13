part of 'track_status_bloc.dart';

abstract class TrackStatusEvent {
  const TrackStatusEvent();
}

class LoadComplaintStatusEvent extends TrackStatusEvent {
  const LoadComplaintStatusEvent();
}
