

import 'package:flutter/material.dart';
import 'package:selectos/src/config/enums.dart';

extension LoadingStyleExtension on LoadingStyle {

  Widget get widget {
    switch (this) {
      case LoadingStyle.circular:
        return const CircularProgressIndicator();
      case LoadingStyle.linear:
        return const LinearProgressIndicator();
      case LoadingStyle.textCircular:
        return const CircularProgressIndicator();
      case LoadingStyle.textLinear:
        return const LinearProgressIndicator();
      case LoadingStyle.none:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }

}