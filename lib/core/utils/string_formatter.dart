class StringFormatter {
  StringFormatter._();
  static final StringFormatter _instance = StringFormatter._();
  factory StringFormatter() {
    return _instance;
  }

  static String currencyFormat(int rupees) {
    String rupeesStr = rupees.abs().toString();
    String sign = rupees < 0 ? '-' : '';

    if (rupeesStr.length <= 3) {
      return sign + rupeesStr;
    }

    String lastThree = rupeesStr.substring(rupeesStr.length - 3);
    String otherNumbers = rupeesStr.substring(0, rupeesStr.length - 3);
    if (otherNumbers != '') {
      lastThree = ',$lastThree';
    }
    String res = otherNumbers.replaceAllMapped(RegExp(r'\B(?=(\d{2})+(?!\d))'),
            (Match match) {
          return ',${match.group(0)!}';
        }) +
        lastThree;
    return sign + res;
  }

  static String obfuscateText(
      {required String text,
      bool obfuscateFromStart = true,
      int revealDigits = 4,
      int? fixLength,
      bool obfuscateMiddle = false,
      String? obfuscateChar}) {
    if (text.length <= revealDigits) {
      return text; // If text is too short, return as is
    }

    if (obfuscateMiddle) {
      int revealEachSide = revealDigits ~/ 2;
      if (text.length <= revealEachSide * 2) {
        return text; // If text is too short to obfuscate middle, return as is
      }
      String start = text.substring(0, revealEachSide);
      String end = text.substring(text.length - revealEachSide);
      String obfuscatedPart = (obfuscateChar ?? '*') *
          (fixLength != null
              ? (fixLength - (revealEachSide * 2))
              : (text.length - (revealEachSide * 2)));
      return start + obfuscatedPart + end;
    }

    int obfuscateLength = text.length - revealDigits;
    String obfuscatedPart = (obfuscateChar ?? '*') *
        (fixLength != null ? fixLength - revealDigits : obfuscateLength);

    if (obfuscateFromStart) {
      return obfuscatedPart + text.substring(obfuscateLength);
    } else {
      return text.substring(0, revealDigits) + obfuscatedPart;
    }
  }

  static String toSnakeCase(String? input) {
    if (input == null) return '';
    String cleaned = input.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
    cleaned = cleaned.replaceAll(RegExp(r'[^A-Za-z0-9 ]'), ' ');
    String snakeCase = cleaned.toLowerCase().replaceAll(' ', '_');
    snakeCase = snakeCase.replaceAll(RegExp(r'_+'), '_');
    return snakeCase;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (trim().isEmpty) return '';
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String capitalizeEachWord() {
    if (trim().isEmpty) return '';
    return toLowerCase()
        .split(' ')
        .map((word) =>
            word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }
}
