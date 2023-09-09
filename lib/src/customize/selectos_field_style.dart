import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:selectos/src/config/constants.dart';

class SelectosFieldStyle {

  const SelectosFieldStyle({
    this.fontSize = 16.0,
    this.iconSize = 20.0,
    this.inputMaxHeight = 45.0,
    this.inputMinHeight = 45.0,
    this.hintTextColor = Colors.grey,
    this.backgroundColor = Colors.white,
    this.searchColor = Colors.white,
    this.selectedColor = const Color(0xfff1f1f1),
    this.selectedTextColor = const Color(0xff212529),
    this.textColor = const Color(0xff212529),
    this.disabledColor = const Color(0xffe7e7e7),
    this.disabledTextColor = const Color(0xffdedede),
    this.focusedTextColor = const Color(0xff212529),
    this.arrowIcon = CupertinoIcons.chevron_down,
    this.clearIcon = CupertinoIcons.clear,
    this.searchTextColor = const Color(0xff212529),
    this.border,
    this.focusedBorder,
    this.focusedBoxShadow = const [],
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
    this.decoration = bordered,
    this.searchDecoration = bordered,
  });

  final InputDecoration searchDecoration;

  final InputDecoration decoration;

  final BorderRadiusGeometry? borderRadius;

  final Color textColor;

  final Color hintTextColor;

  final Color selectedColor;

  final Color selectedTextColor;

  final Color disabledColor;

  final Color disabledTextColor;

  final Color backgroundColor;

  final BoxBorder? border;

  final double fontSize;

  final double iconSize;

  final IconData arrowIcon;

  final IconData clearIcon;

  final List<BoxShadow> focusedBoxShadow;

  final BoxBorder? focusedBorder;

  final Color focusedTextColor;

  final Color searchColor;

  final Color searchTextColor;

  final double inputMaxHeight;

  final double inputMinHeight;

  static const InputDecoration bordered = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    isDense: true,
    hintText: HINT,
    hintStyle: TextStyle(color: Colors.grey),
  );

}
