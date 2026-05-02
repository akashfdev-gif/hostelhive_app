import 'package:flutter/material.dart';
import 'package:hostel_hive/core/app_export.dart';

class CustomBreadcrumb extends StatelessWidget {
  const CustomBreadcrumb({
    super.key,
    required this.actions,
    required this.active,
  });
  final List<String> actions;
  final int active;

  @override
  Widget build(BuildContext context) {
    int scrollOffset = active - 1;
    ScrollController controller =
        ScrollController(initialScrollOffset: scrollOffset * 100.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50)).then((value) {
        if (controller.hasClients) {
          controller.animateTo(
            active * 100.0, // Adjust item width accordingly
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      });
    });

    return Container(
      width: double.infinity,
      height: 42.h,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: appTheme.gray20001, width: 1),
            bottom: BorderSide(color: appTheme.gray20001, width: 1)),
        color: appTheme.otherWhite,
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 20.w),
          child: Row(
            children: actions.asMap().entries.map((entry) {
              int index = entry.key;
              String action = entry.value;
              return Row(
                children: [
                  Text(
                    action,
                    style: CustomTextStyle.textSmMedium.copyWith(
                        color: index <= active
                            ? appTheme.blue800
                            : appTheme.black700),
                  ),
                  if (index != actions.length - 1)
                    Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16.w,
                        color: appTheme.black600,
                      ),
                    )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
