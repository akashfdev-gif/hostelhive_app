import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._();
  static final ScreenUtil _instance = ScreenUtil._();
  factory ScreenUtil() {
    return _instance;
  }

  static Size get size =>
      WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
      WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

  /// Get the size based on Viewport width for horizontal layout.
  ///
  /// [px] - The size in pixels to be converted.
  static double getHorizontalSize(double px) {
    return px * (size.width / 428);
  }

  /// Get the size based on Viewport height for vertical layout.
  ///
  /// [px] - The size in pixels to be converted.
  static double getVerticalSize(double px) {
    num statusBar = MediaQueryData.fromView(WidgetsBinding
            .instance
            .platformDispatcher
            .views
            .first) //window changed to platformDispatcher as it was deprecated
        .viewPadding
        .top;
    num screenHeight = size.height - statusBar;
    return px * (screenHeight / 882);
  }

  /// Get the font size based on Viewport for responsive text.
  ///
  /// [px] - The size in pixels to be converted.
  static double getFontSize(double px) {
    var height = ScreenUtil.getVerticalSize(px);
    var width = ScreenUtil.getHorizontalSize(px);
    return (height < width)
        ? height.toInt().toDouble()
        : width.toInt().toDouble();
  }

  /// Get the smallest size based on Viewport for responsive images.
  ///
  /// [px] - The size in pixels to be converted.
  static double getSize(double px) {
    return ScreenUtil.getFontSize(px);
  }

  /// Get responsive padding based on Viewport.
  ///
  /// You can specify padding values for all sides or individually.
  /// [all] - Padding for all sides.
  /// [left] - Padding for the left side.
  /// [top] - Padding for the top side.
  /// [right] - Padding for the right side.
  /// [bottom] - Padding for the bottom side.
  static EdgeInsetsGeometry getPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: ScreenUtil.getHorizontalSize(left ?? 0),
      top: ScreenUtil.getVerticalSize(top ?? 0),
      right: ScreenUtil.getHorizontalSize(right ?? 0),
      bottom: ScreenUtil.getVerticalSize(bottom ?? 0),
    );
  }

  /// Get responsive margin based on Viewport.
  ///
  /// You can specify margin values for all sides or individually.
  /// [all] - Margin for all sides.
  /// [left] - Margin for the left side.
  /// [top] - Margin for the top side.
  /// [right] - Margin for the right side.
  /// [bottom] - Margin for the bottom side.
  static EdgeInsetsGeometry getMargin({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: ScreenUtil.getHorizontalSize(left ?? 0),
      top: ScreenUtil.getVerticalSize(top ?? 0),
      right: ScreenUtil.getHorizontalSize(right ?? 0),
      bottom: ScreenUtil.getVerticalSize(bottom ?? 0),
    );
  }
}
