import 'package:bs_flutter_utils/bs_flutter_utils.dart';
import 'package:flutter/material.dart';

class BsSelectBoxStyle {
  const BsSelectBoxStyle({
    this.borderRadius = const BorderRadius.all(Radius.circular(5.0)),
    this.fontSize = 12.0,
    this.selectedColor = const Color(0xfff1f1f1),
    this.selectedTextColor = const Color(0xff212529),
    this.textColor = const Color(0xff212529),
    this.hintTextColor = Colors.grey,
    this.border,
    this.disabledColor = const Color(0xffe7e7e7),
    this.disabledTextColor = const Color(0xffdedede),
    this.backgroundColor = Colors.white,
    this.arrowIcon = Icons.arrow_drop_down,
    this.focusedBoxShadow = const [],
    this.focusedBorder,
    this.focusedTextColor = BsColor.primary,
    this.searchColor = Colors.white,
    this.searchTextColor = const Color(0xff212529)
  });

  /// define border radius of [BsSelectBox]
  final BorderRadiusGeometry? borderRadius;

  /// define color of [BsSelectBox]
  final Color textColor;

  /// define hintTextColor of [BsSelectBox]
  final Color hintTextColor;

  /// define selectedBackgroundColor of [BsSelectBox]
  final Color selectedColor;

  /// define selectedColor of [BsSelectBox]
  final Color selectedTextColor;

  /// define of disabledColor of [BsSelectBox]
  final Color disabledColor;

  final Color disabledTextColor;

  /// define of backgroundColor of [BsSelectBox]
  final Color backgroundColor;

  /// define borderColor of [BsSelectBox]
  final BoxBorder? border;

  /// define fontSize of [BsSelectBox]
  final double fontSize;

  /// defien arrowIcon of [BsSelectBox]
  final IconData arrowIcon;

  final List<BoxShadow> focusedBoxShadow;

  final BoxBorder? focusedBorder;

  final Color focusedTextColor;

  final Color searchColor;

  final Color searchTextColor;

  static const BsSelectBoxStyle bordered = BsSelectBoxStyle(
    border: Border(
      top: BorderSide(color: BsColor.borderColor),
      bottom: BorderSide(color: BsColor.borderColor),
      left: BorderSide(color: BsColor.borderColor),
      right: BorderSide(color: BsColor.borderColor),
    ),
    focusedBoxShadow: [
      BoxShadow(
        color: BsColor.primaryShadow,
        offset: Offset(0, 0),
        spreadRadius: 2.5,
      )
    ],
    focusedBorder: Border(
      top: BorderSide(color: BsColor.primary),
      bottom: BorderSide(color: BsColor.primary),
      left: BorderSide(color: BsColor.primary),
      right: BorderSide(color: BsColor.primary),
    )
  );
}
