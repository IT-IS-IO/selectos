import 'package:flutter/material.dart';
import 'package:selectos/src/customize/selectos_field_style.dart';

class SelectosDialogStyle {

  const SelectosDialogStyle({
    this.maxHeight = 300.0,
    this.search = const SelectosFieldStyle(),
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        // bottom shadow

      ],
    ),
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.only(top: 2.0, bottom: 2.0),
  });

  final BoxDecoration? decoration;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final double maxHeight;

  final SelectosFieldStyle search;


}