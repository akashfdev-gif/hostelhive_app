part of 'food_feedback_bloc.dart';

abstract class FoodFeedbackEvent {}

class FoodFeedbackInitialEvent extends FoodFeedbackEvent {
  FoodFeedbackInitialEvent({required this.mealRating});

  final int mealRating;
}

class FoodFeedbackRatingChangedEvent extends FoodFeedbackEvent {
  FoodFeedbackRatingChangedEvent({required this.rating});

  final int rating;
}

class FoodFeedbackTextChangedEvent extends FoodFeedbackEvent {
  FoodFeedbackTextChangedEvent({required this.feedback});

  final String feedback;
}

class FoodFeedbackMealTypeChangedEvent extends FoodFeedbackEvent {
  FoodFeedbackMealTypeChangedEvent({required this.mealType});

  final String mealType;
}

class FoodFeedbackSubmitEvent extends FoodFeedbackEvent {}

class FoodFeedbackResetSubmittedEvent extends FoodFeedbackEvent {}
