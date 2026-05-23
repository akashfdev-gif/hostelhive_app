part of 'food_feedback_bloc.dart';

class FoodFeedbackState extends Equatable {
  const FoodFeedbackState({
    this.feedback = '',
    this.selectedMealType = 'lbl_lunch',
    this.mealRating = 0,
    this.isSubmitted = false,
  });

  final String feedback;
  final String selectedMealType;
  final int mealRating;
  final bool isSubmitted;

  bool get canSubmit =>
      feedback.trim().isNotEmpty && mealRating > 0;

  @override
  List<Object?> get props =>
      [feedback, selectedMealType, mealRating, isSubmitted];

  FoodFeedbackState copyWith({
    String? feedback,
    String? selectedMealType,
    int? mealRating,
    bool? isSubmitted,
  }) {
    return FoodFeedbackState(
      feedback: feedback ?? this.feedback,
      selectedMealType: selectedMealType ?? this.selectedMealType,
      mealRating: mealRating ?? this.mealRating,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}
