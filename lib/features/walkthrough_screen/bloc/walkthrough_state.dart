part of 'walkthrough_bloc.dart';

class WalkthroughState extends Equatable {
  const WalkthroughState({this.isNavigating = false});

  final bool isNavigating;

  @override
  List<Object?> get props => [isNavigating];

  WalkthroughState copyWith({bool? isNavigating}) {
    return WalkthroughState(
      isNavigating: isNavigating ?? this.isNavigating,
    );
  }
}
