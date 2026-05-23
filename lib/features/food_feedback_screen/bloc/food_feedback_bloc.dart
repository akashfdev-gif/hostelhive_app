import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'food_feedback_event.dart';
part 'food_feedback_state.dart';

class FoodFeedbackBloc extends Bloc<FoodFeedbackEvent, FoodFeedbackState> {
  FoodFeedbackBloc() : super(const FoodFeedbackState()) {
    on<FoodFeedbackInitialEvent>(_onInitialize);
    on<FoodFeedbackTextChangedEvent>(_onTextChanged);
    on<FoodFeedbackMealTypeChangedEvent>(_onMealTypeChanged);
    on<FoodFeedbackRatingChangedEvent>(_onRatingChanged);
    on<FoodFeedbackSubmitEvent>(_onSubmit);
    on<FoodFeedbackResetSubmittedEvent>(_onResetSubmitted);
  }

  void _onInitialize(
    FoodFeedbackInitialEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    emit(FoodFeedbackState(mealRating: event.mealRating));
  }

  void _onRatingChanged(
    FoodFeedbackRatingChangedEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    emit(state.copyWith(mealRating: event.rating));
  }

  void _onTextChanged(
    FoodFeedbackTextChangedEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    emit(state.copyWith(feedback: event.feedback));
  }

  void _onMealTypeChanged(
    FoodFeedbackMealTypeChangedEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    emit(state.copyWith(selectedMealType: event.mealType));
  }

  void _onSubmit(
    FoodFeedbackSubmitEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitted: true));
  }

  void _onResetSubmitted(
    FoodFeedbackResetSubmittedEvent event,
    Emitter<FoodFeedbackState> emit,
  ) {
    emit(state.copyWith(isSubmitted: false));
  }
}
