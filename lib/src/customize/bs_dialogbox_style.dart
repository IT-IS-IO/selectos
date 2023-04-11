import 'package:flutter/material.dart';

class BsDialogBoxStyle {

  const BsDialogBoxStyle({
    this.itemColor,
    this.itemTextColor,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.boxShadow
  });

  final Color? itemColor;

  final Color? itemTextColor;

  final Color? backgroundColor;

  final BorderRadius? borderRadius;

  final Border? border;

  final List<BoxShadow>? boxShadow;
}