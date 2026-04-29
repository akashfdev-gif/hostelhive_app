import 'package:book_store/core/utils/logger.dart';
import 'package:book_store/themes/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:book_store/v2/core/app_export.dart';

/// Returns a CircleAvatar widget with:
/// - The initial of the name (first letter of first word, uppercased)
/// - A random but deterministic background color based on the first initial (A-Z)
/// - White text color for contrast

class NamedAvatar extends StatelessWidget {
  final String name;
  final String? image;
  final double radius, fontSize;
  const NamedAvatar(
      {super.key,
      required this.name,
      this.image,
      this.radius = 24.0,
      this.fontSize = 20.0});

  @override
  Widget build(BuildContext context) {
    String trimmed = name.trim();
    if (trimmed.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: appTheme.blue700,
        child: Icon(Icons.person, color: Colors.white, size: fontSize),
      );
    }

    try {
      // Extract the first character of the first word
      trimmed = trimmed.replaceAll(
          RegExp(r"\s{2,}"), ' '); // remove any extra spaces in between
      List<String> nameSplit = trimmed.toUpperCase().split(' ');
      String initial = nameSplit.first[0];
      String secondInitial = "";
      if (nameSplit.length > 1 && nameSplit[1].isNotEmpty) {
        secondInitial = nameSplit[1][0];
      }

      return CircleAvatar(
        radius: radius,
        backgroundColor: appTheme.blue700,
        backgroundImage: image == null ? null : NetworkImage(image!),
        onBackgroundImageError: image == null
            ? null
            : (exception, stackTrace) {
                logger.d("Failed to profile picture");
              },
        child: image == null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    "$initial$secondInitial",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ),
              )
            : null,
      );
    } catch (e) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: appTheme.blue700,
        child: Icon(Icons.person, color: Colors.white, size: fontSize),
      );
    }
  }
}
