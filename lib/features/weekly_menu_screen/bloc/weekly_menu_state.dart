part of 'weekly_menu_bloc.dart';

class WeeklyMenuDayItem extends Equatable {
  const WeeklyMenuDayItem({
    required this.dayKey,
    required this.breakfastKey,
    required this.lunchKey,
    required this.dinnerKey,
  });

  final String dayKey;
  final String breakfastKey;
  final String lunchKey;
  final String dinnerKey;

  @override
  List<Object?> get props => [dayKey, breakfastKey, lunchKey, dinnerKey];
}

class WeeklyMenuState extends Equatable {
  const WeeklyMenuState({this.weeklyMenu = const []});

  final List<WeeklyMenuDayItem> weeklyMenu;

  @override
  List<Object?> get props => [weeklyMenu];

  WeeklyMenuState copyWith({List<WeeklyMenuDayItem>? weeklyMenu}) {
    return WeeklyMenuState(weeklyMenu: weeklyMenu ?? this.weeklyMenu);
  }
}
