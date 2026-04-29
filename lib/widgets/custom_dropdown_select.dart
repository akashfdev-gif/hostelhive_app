import 'package:book_store/core/utils/size_utils.dart';
import 'package:book_store/themes/custom_text_style.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:book_store/v2/core/app_export.dart';

/// A custom dropdown widget that allows users to select an option from a list.
///
/// The dropdown displays a list of options when tapped, and the selected option
/// is displayed in the dropdown field. The dropdown can be customized with a label,
/// initial selected value, and an offset for the dropdown position.
///
/// [options] is a required list of strings that represents the dropdown options.
/// [labelText] is a required string that represents the label for the dropdown.
/// [initialValue] is an optional string that represents the initially selected value.
/// [offset] is an optional Offset that adjusts the position of the dropdown.
/// [onChange] is an optional callback function that is called when an option is selected.
///
class CustomDropdownSelect extends StatefulWidget {
  const CustomDropdownSelect(
      {super.key,
      required this.options,
      this.labelText,
      this.initialValue,
      this.offset,
      this.onChange,
      this.labelLowercase = false,
      this.customTextStyle,
      this.dropdownButtonTextStyle,
      this.showSeperator = true,
      this.minDropdownTileHeight,
      this.dropdownIcon,
      this.borderRadius,
      this.width,
      this.height,
      this.dropdownColor,
      this.verticalPadding,
      this.horizontalPadding,
      this.prefixIcon,
      });

  final List<String> options;
  final String? labelText;
  final String? initialValue;
  final Offset? offset;
  final void Function(String)? onChange;
  final bool labelLowercase;
  final TextStyle? customTextStyle;
  final TextStyle? dropdownButtonTextStyle;
  final Widget? dropdownIcon;
  final BorderRadius? borderRadius;
  final bool showSeperator;
  final double? minDropdownTileHeight;
  final double? width;
  final double? height;
  final Color? dropdownColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Widget? prefixIcon;

  @override
  State<CustomDropdownSelect> createState() => _CustomDropdownSelectState();
}

class _CustomDropdownSelectState extends State<CustomDropdownSelect> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  String? selectedVal;
  @override
  void initState() {
    super.initState();
    selectedVal = widget.initialValue;
  }

  void _toggleDropdown(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _overlayEntry?.remove();
                _overlayEntry = null;
              },
            ),
          ),
          Positioned(
            width: widget.width ?? 358.w,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: widget.offset ??
                  const Offset(0, 55), // Adjusts dropdown position
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10.h),
                color: widget.dropdownColor ?? appTheme.otherWhite,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200.h, // Set max height for scrolling
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.options
                          .map(
                            (option) => Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: widget.horizontalPadding !=
                                          null
                                      ? EdgeInsets.symmetric(
                                          horizontal: widget.horizontalPadding!)
                                      : null,
                                  minTileHeight: widget.minDropdownTileHeight,
                                  title: Text(option,
                                      style: widget.dropdownButtonTextStyle ??
                                          CustomTextStyle.textBaseRegular
                                              .copyWith(
                                                  color: appTheme.black900)),
                                  onTap: () {
                                    setState(() {
                                      selectedVal = option;
                                      widget.onChange?.call(option);
                                    });
                                    _toggleDropdown(context);
                                  },
                                ),
                                if (widget.showSeperator)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: option != widget.options.last
                                            ? Border(
                                                bottom: BorderSide(
                                                    color:
                                                        widget.dropdownColor !=
                                                                null
                                                            ? appTheme
                                                                .otherWhite
                                                            : appTheme.black50,
                                                    width: 1))
                                            : null,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.labelText != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                    widget.labelLowercase
                        ? widget.labelText!
                        : widget.labelText!.toUpperCase(),
                    style: widget.customTextStyle ??
                        CustomTextStyle.textXsMedium
                            .copyWith(color: appTheme.black600)),
              )
            : const SizedBox.shrink(),
        CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              onTap: () => _toggleDropdown(context),
              child: Container(
                height: widget.height,
                width: widget.width,
                padding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding ?? 12.h,
                  horizontal: widget.horizontalPadding ?? 12.w,
                ),
                decoration: BoxDecoration(
                    color: widget.dropdownColor ?? appTheme.otherWhite,
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(8.w),
                    border: Border.all(color: appTheme.otherBorder, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.prefixIcon != null)
                      Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: widget.prefixIcon!,
                      ),
                    Expanded(
                      child: Text(selectedVal ?? widget.initialValue ?? 'Select',
                          overflow: TextOverflow.ellipsis,
                          style: widget.dropdownButtonTextStyle ??
                              CustomTextStyle.textBaseRegular
                                  .copyWith(color: appTheme.black900)),
                    ),
                    if (widget.dropdownIcon != null) widget.dropdownIcon!,
                    if (widget.dropdownIcon == null)
                      const Icon(Icons.keyboard_arrow_down,
                          color: Color(0xFF333333)),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    super.dispose();
  }
}
