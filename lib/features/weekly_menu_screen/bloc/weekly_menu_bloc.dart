import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weekly_menu_event.dart';
part 'weekly_menu_state.dart';

class WeeklyMenuBloc extends Bloc<WeeklyMenuEvent, WeeklyMenuState> {
  WeeklyMenuBloc() : super(const WeeklyMenuState()) {
    on<WeeklyMenuInitialEvent>(_onInitialize);
  }

  void _onInitialize(
    WeeklyMenuInitialEvent event,
    Emitter<WeeklyMenuState> emit,
  ) {
    emit(
      state.copyWith(
        weeklyMenu: const [
          WeeklyMenuDayItem(
            dayKey: 'lbl_monday',
            breakfastKey: 'msg_mon_breakfast',
            lunchKey: 'msg_mon_lunch',
            dinnerKey: 'msg_mon_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_tuesday',
            breakfastKey: 'msg_tue_breakfast',
            lunchKey: 'msg_tue_lunch',
            dinnerKey: 'msg_tue_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_wednesday',
            breakfastKey: 'msg_wed_breakfast',
            lunchKey: 'msg_wed_lunch',
            dinnerKey: 'msg_wed_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_thursday',
            breakfastKey: 'msg_thu_breakfast',
            lunchKey: 'msg_thu_lunch',
            dinnerKey: 'msg_thu_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_friday',
            breakfastKey: 'msg_fri_breakfast',
            lunchKey: 'msg_fri_lunch',
            dinnerKey: 'msg_fri_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_saturday',
            breakfastKey: 'msg_sat_breakfast',
            lunchKey: 'msg_sat_lunch',
            dinnerKey: 'msg_sat_dinner',
          ),
          WeeklyMenuDayItem(
            dayKey: 'lbl_sunday',
            breakfastKey: 'msg_sun_breakfast',
            lunchKey: 'msg_sun_lunch',
            dinnerKey: 'msg_sun_dinner',
          ),
        ],
      ),
    );
  }
}
