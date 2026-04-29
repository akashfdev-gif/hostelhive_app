import 'package:book_store/core/utils/pref_utils.dart';
import 'package:book_store/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

import '../core/app_export.dart';

LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.
class ThemeHelper {
  // The current app theme
  final _appTheme = PrefUtils().getThemeData();

  // A map of custom color themes supported by the app
  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

// A map of color schemes supported by the app
  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
        visualDensity: VisualDensity.standard,
        colorScheme: colorScheme,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.black54),
        textTheme: TextThemes.textTheme(colorScheme),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.h),
            ),
            elevation: 0,
            visualDensity: const VisualDensity(
              vertical: -4,
              horizontal: -4,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: appTheme.indigoA200,
            side: BorderSide(
              color: appTheme.indigoA20001,
              width: 1.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26.h),
            ),
            visualDensity: const VisualDensity(
              vertical: -4,
              horizontal: -4,
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          space: 1,
          color: appTheme.gray200,
        ),
        appBarTheme: AppBarTheme(
            centerTitle: true,
            iconTheme:
                IconThemeData(color: appTheme.otherWhite, size: 24, weight: 1),
            backgroundColor: colorScheme.primary,
            titleTextStyle: TextStyle(
              color: appTheme.otherWhite,
              fontSize: 18.fSize,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            )));
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// return the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static const lightCodeColorScheme = ColorScheme.light(
    primary: Color(0xFF263192),
    errorContainer: Color(0XFFFF1114),
  );
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.gray900,
          fontSize: 16.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.gray800.withValues(
            alpha: 0.8,
          ),
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.gray500,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 36.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.onErrorContainer,
          fontSize: 32.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: appTheme.gray900,
          fontSize: 24.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appTheme.gray700,
          fontSize: 12.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: appTheme.gray900,
          fontSize: 20.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: appTheme.gray900.withValues(
            alpha: 0.8,
          ),
          fontSize: 16.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appTheme.indigoA700,
          fontSize: 14.fSize,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Blue
  Color get blue950 => const Color(0xFF233296);
  Color get blue900 => const Color(0xFF263192);
  Color get blue800 => const Color(0xFF3643A3);
  Color get blue700 => const Color(0xFF4655B4);
  Color get blue650 => const Color(0xFF5667C5);
  Color get blue600 => const Color(0xFF6679D6);
  Color get blue500 => const Color(0xFF778CE6);
  Color get blue400 => const Color(0xFF8F9FEF);
  Color get blue300 => const Color(0xFFA8B4F5);
  Color get blue200 => const Color(0xFFC1C9FA);
  Color get blue100 => const Color(0xFFDBDFFF);
  Color get blue50 => const Color(0xFF56DAFF);

  Color get black900 => const Color(0xFF212121);
  Color get black800 => const Color(0xFF373737);
  Color get black700 => const Color(0xFF4D4D4D);
  Color get black600 => const Color(0xFF646464);
  Color get black500 => const Color(0xFF7A7A7A);
  Color get black400 => const Color(0xFF909090);
  Color get black300 => const Color(0xFFA6A6A6);
  Color get black200 => const Color(0xFFBCBCBC);
  Color get black100 => const Color(0xFFD3D3D3);
  Color get black50 => const Color(0xFFE9E9E9);

  // Green
  Color get green900 => const Color(0xFF06A358);
  Color get green800 => const Color(0xFF1FAC68);
  Color get green700 => const Color(0xFF38B579);
  Color get green600 => const Color(0xFF51BE8A);
  Color get green500 => const Color(0xFF6AC89B);
  Color get green400 => const Color(0xFF82D1AB);
  Color get green300 => const Color(0xFF9BDABC);
  Color get green200 => const Color(0xFFB4E3CD);
  Color get green100 => const Color(0xFFCDEDDE);
  Color get green50 => const Color(0xFFE6F6EE);
  Color get barGreenLight => const Color(0xFF46FF8A);
  Color get barGreenDark => const Color(0xFF2B9F56);

  // Red
  Color get red900 => const Color(0xFFCB414E);
  Color get red800 => const Color(0xFFD05460);
  Color get red700 => const Color(0xFFD56771);
  Color get red600 => const Color(0xFFDB7A83);
  Color get red500 => const Color(0xFFE08D95);
  Color get red400 => const Color(0xFFE5A0A6);
  Color get red300 => const Color(0xFFEAB3B8);
  Color get red200 => const Color(0xFFEFC6CA);
  Color get red150 => const Color(0xFFFFEAD5);
  Color get red100 => const Color(0xFFF5D9DC);
  Color get red50 => const Color(0xFFFAECED);
  Color get peach50 => const Color(0xFFFFC3A4);

  // Orange
  Color get orange900 => const Color.fromRGBO(218, 145, 1, 1);
  Color get orange50 => const Color.fromRGBO(255, 234, 213, 1);

  // Others
  Color get otherLink => const Color(0xFF1A35FE);
  Color get otherBackground => const Color(0xFFF6F8FA);
  Color get otherWhite => const Color(0xFFFFFFFF);
  Color get otherBlack => const Color(0xFF000000);
  Color get otherBorder => const Color(0xFFD0DBEA);
  Color get otherYellow => const Color(0xFFF5BE00);

  Color get otherLightBorder => const Color.fromRGBO(208, 219, 234, 0.5);
  Color get transparent => const Color(0x00000000);
  Color get otherTransparent => const Color(0x0FFFFFFF);
  Color get otherHintText => const Color(0xFF8E8E93);
  Color get otherOrangeBorder => const Color(0xffECBD8D);
  Color get otherGreenBorder => const Color(0xff8DDCB7);
  Color get otherRedBorder => const Color(0xFFEB9DA0);
  Color get otherGreen => const Color(0xff12EA27);
  Color get otherAmber => const Color(0xFFFFC107);

  // Indigo
  Color get indigoA200 => const Color(0XFF4D61FE);
  Color get indigoA20001 => const Color(0XFF6778FE);
  Color get indigoA500 => const Color(0xff5063F7);
  Color get indigoA600 => const Color(0xFF334BFF);
  Color get indigoA700 => const Color(0XFF1A34FE);
  Color get indigoA800 => const Color(0xff3b5fdd);
  Color get indigoA900 => const Color(0xff2344eb);

  // Gray
  Color get gray100 => const Color(0xFFF5F5F5);
  Color get gray150 => const Color(0XFFD9D9D9);
  Color get gray200 => const Color(0XFFE8E8E8);
  Color get gray20001 => const Color(0XFFEBEBEB);
  Color get gray400 => const Color(0XFFBCBCBC);
  Color get gray40001 => const Color(0XFFC2C2C2);
  Color get gray50 => const Color(0XFFF6F8FA);
  Color get gray500 => const Color(0XFF909090);
  Color get gray550 => const Color(0x80E9E9E9);
  Color get gray50001 => const Color(0XFF999999);
  Color get gray600 => const Color(0XFF797979);
  Color get gray60001 => const Color(0XFF707070);
  Color get gray700 => const Color(0XFF636363);
  Color get gray800 => const Color(0XFF4D4D4D);
  Color get gray80001 => const Color(0XFF474747);
  Color get gray900 => const Color(0xFF181818);
  Color get gray90001 => const Color(0XFF1A1C1E);

  // Bar Colors (Exact)
  Color get barRed => const Color(0xFFFF4A2A);
  Color get barPeach => const Color(0xFFE8B97A);
  Color get barYellow => const Color(0xFFF4B400);
  Color get barBlue => const Color(0xFF4A6CF7);
  Color get barPurple => const Color(0xFF7E8CE0);
  Color get barGreen => const Color(0xFF2DBE60);
  Color get blueGrey50 => const Color(0xFFEEF0FA);
  // BoxShadows
  List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withAlpha(5),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];
}
