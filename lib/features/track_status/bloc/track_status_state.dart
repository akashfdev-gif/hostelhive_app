part of 'track_status_bloc.dart';

class TrackStatusState extends Equatable {
  const TrackStatusState({
    this.complaints = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<ComplaintModel> complaints;
  final bool isLoading;
  final String? errorMessage;

  TrackStatusState copyWith({
    List<ComplaintModel>? complaints,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TrackStatusState(
      complaints: complaints ?? this.complaints,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [complaints, isLoading, errorMessage];
}
