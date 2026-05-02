import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';
const String dMy = 'dd/MM/yyyy';

extension DateTimeExtension on DateTime {
  String format({String pattern = dateTimeFormatPattern, String? locale}) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }
}

extension DateToStringExtension on String {
  String dateToString() {
    DateTime parsedDate = DateTime.parse(this);
    DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(parsedDate);
  }

  DateTime stringToDate() {
    DateFormat format = DateFormat("dd MMM yyyy");
    DateTime dateTime = format.parse(this);
    return dateTime;
  }
}
