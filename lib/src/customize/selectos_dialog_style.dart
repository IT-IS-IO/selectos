import 'package:flutter/material.dart';

class SelectosDialogStyle {

  const SelectosDialogStyle({
    this.maxHeight = 300.0,
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          spreadRadius: 5.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.only(top: 2.0, bottom: 2.0),
  });

  final BoxDecoration? decoration;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final double maxHeight;


}