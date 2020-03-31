import 'package:flutter/cupertino.dart';
import 'package:flutter_project1/util/screen.dart';

/// 通用的style
class CStyle {
  static TextStyle style(Color color, double fontSize, [bool bold = false]) {
    return TextStyle(
        color: color,
        decoration: TextDecoration.none,
        fontSize: Screen.sp(fontSize),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}
