import 'package:intl/intl.dart';
import 'package:hostel_hive/core/app_export.dart';

extension CurrencyExtensions on num {
  String toCurrencyFormatString({int? decimalPlaces}) {
    int decimals = 0;
    if ("$this".contains('.')) {
      decimals = 2;
    }
    if ("$this".endsWith('.0') || "$this".contains('.00')) {
      decimals = 0;
    }
    final formatter = NumberFormat.currency(
        name: "INR ",
        symbol: 'lbl'.tr,
        decimalDigits: decimals == 0 ? 0 : decimalPlaces ?? decimals,
        locale: 'en_IN');
    return formatter.format(this);
  }
}

extension CurrencyExtensionsString on String {
  num currencyToNum() {
    String sanitizedString = replaceAll(RegExp(r'[^\d.]'), '');
    return num.parse(sanitizedString);
  }
}
