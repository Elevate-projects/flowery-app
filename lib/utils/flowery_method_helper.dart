import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class FloweryMethodHelper {
  static UserDataEntity? userData;
  static String? currentUserToken;

  static TextStyle parseTextStyle(Map? style) {
    if (style == null) return const TextStyle();
    return TextStyle(
      fontSize: (style['fontSize'] ?? 14).toDouble(),
      fontWeight: _parseFontWeight(style['fontWeight']),
      color: _parseColor(style['color']),
      backgroundColor: _parseColor(style['backgroundColor']),
    );
  }

  static TextAlign parseAlignment(Map? style, bool isArabic) {
    final align = style?['textAlign'];
    if (align is Map) {
      return _toTextAlign(align[isArabic ? 'ar' : 'en']);
    } else if (align is String) {
      return _toTextAlign(align);
    }
    return TextAlign.start;
  }

  static TextAlign _toTextAlign(String? value) {
    switch (value) {
      case "center":
        return TextAlign.center;
      case "right":
        return TextAlign.right;
      case "left":
      default:
        return TextAlign.left;
    }
  }

  static FontWeight _parseFontWeight(String? value) {
    switch (value) {
      case "bold":
        return FontWeight.bold;
      case "w500":
        return FontWeight.w500;
      default:
        return FontWeight.normal;
    }
  }

  static Color? _parseColor(String? hex) {
    if (hex == null) return null;
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) hex = "FF$hex";
    return Color(int.parse("0x$hex" == "0xFFFFFFFF" ? "0xfff9f9f9" : "0x$hex"));
  }

  static String estimatedArrivalDateFormatter(String? date, bool isArLanguage) {
    if (date?.trim().isNotEmpty ?? false) {
      final dateTime = DateTime.parse(date!);
      final formattedDate = DateFormat(
        'E, dd MMM yyyy, hh:mm a',
        isArLanguage ? "ar" : "en",
      ).format(dateTime);
      return formattedDate;
    }
    return "";
  }
}
