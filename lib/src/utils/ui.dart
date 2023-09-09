





import 'package:flutter/material.dart';
import 'package:selectos/src/config/methods.dart';
import 'package:selectos/src/customize/selectos_field_style.dart';

class SelectosUiUtils {


  static Widget generateHintWidget(String? hintText, bool valid, SelectosFieldStyle style) {
    return isNull(hintText)
        ? const SizedBox()
        : Text(
          hintText!,
          style: TextStyle(
              color: valid ? style.hintTextColor : Colors.red,
              fontSize: style.fontSize
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
      );
  }




}