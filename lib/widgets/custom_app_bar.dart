import 'package:book_store/core/utils/navigator_service.dart';
import 'package:book_store/themes/custom_text_style.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:flutter/material.dart';

import '../core/app_export.dart';

/// A customizable AppBar widget.
///
/// The [CustomAppBar] widget provides a configurable AppBar with various
/// properties to customize its appearance and behavior.
///
/// The [title] parameter is required and must not be null.
///
/// Optional parameters:
/// - [onBackPressed]: A callback function to handle back button press.
/// - [toolbarHeight]: The height of the toolbar. Default is 56.0.
/// - [backgroundColor]: The background color of the AppBar.
/// - [titleTextColor]: The color of the title text.
/// - [iconColor]: The color of the back button icon.
/// - [elevation]: The elevation of the AppBar. Default is 0.0.
/// - [centerTitle]: Whether the title should be centered. Default is true.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final double toolbarHeight;
  final Color? backgroundColor;
  final Color? titleTextColor;
  final Color? iconColor;
  final Widget? leading;

  final double elevation;
  final bool centerTitle;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.title,
    this.onBackPressed,
    this.toolbarHeight = 56,
    this.backgroundColor,
    this.titleTextColor,
    this.iconColor,
    this.leading,
    this.elevation = 0.0,
    this.centerTitle = false,
    this.actions = const [],
  }) : assert(title != null, 'Title is required');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? appTheme.blue900,
      toolbarHeight: toolbarHeight,
      elevation: elevation,
      scrolledUnderElevation: elevation,
      actions: actions,
      leading: leading ??
          ((NavigatorService.canGoBack() ?? false)
              ? IconButton(
                  icon: Icon(Icons.arrow_back_sharp,
                      color: iconColor ?? appTheme.otherWhite),
                  onPressed: onBackPressed ?? NavigatorService.goBack,
                )
              : null),
      title: Text(
        title!,
        style: CustomTextStyle.textXlSemiBold
            .copyWith(color: titleTextColor ?? appTheme.otherWhite),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
