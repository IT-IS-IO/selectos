
import 'package:flutter/material.dart';
import 'package:selectos/src/config/constants.dart' show DATA_NOT_FOUND;


class EmptyAddon extends StatelessWidget {

  const EmptyAddon({ super.key, this.text = DATA_NOT_FOUND });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const Icon(Icons.search_off),
        Text(text),

      ],
    );
  }
}
