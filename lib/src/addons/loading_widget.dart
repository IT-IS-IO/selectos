
import 'package:flutter/material.dart';
import 'package:selectos/src/config/constants.dart' show LOADING;
import 'package:selectos/src/config/enums.dart';
import 'package:selectos/src/config/extensions.dart';

class LoadingAddon extends StatelessWidget {

  const LoadingAddon({ super.key, this.text = LOADING, this.style = LoadingStyle.linear });

  final String text;
  final LoadingStyle style;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if (style != LoadingStyle.circular && style != LoadingStyle.linear) ...[
          style.widget,
          Text(text),
        ]
        else style.widget,

      ],
    );
  }
}
