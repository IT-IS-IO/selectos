import 'package:flutter/material.dart';

class SelectosListStyle {

  const SelectosListStyle({
    this.itemColor,
    this.itemTextColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(15),
    this.margin = EdgeInsets.zero,
    this.divider = const Divider(height: 0),
    this.physics = const BouncingScrollPhysics(),
  });

  final Color? itemColor;

  final Color? itemTextColor;

  final Color? backgroundColor;

  final EdgeInsets margin;

  final EdgeInsetsGeometry padding;

  final Divider divider;

  final ScrollPhysics? physics;

}