import 'package:flutter/material.dart';
import 'package:uved/presentation/widgets/external_plugins/bs_flutter_selectbox/bs_flutter_selectbox.dart';

/// define function for renderText options
typedef BsRenderText = Widget Function(dynamic data);

/// define function for set value of option
typedef BsSetOptionValue = dynamic Function(dynamic data);

/// define function fo serverSide mode
typedef BsSelectBoxServerSide = Future<BsSelectBoxResponse> Function(
    Map<String, String> params);

/// class response to handle serverside response
class BsSelectBoxResponse {
  /// Constructor [BsSelectBoxResponse]
  const BsSelectBoxResponse({
    this.options = const [],
  });

  /// define result options from api response
  final List<BsSelectBoxOption> options;

  /// handle response from api with default setting
  ///
  /// In default setting this function will put value index for value option, and text index for text option from response data
  factory BsSelectBoxResponse.createFromJson(List map, {BsSetOptionValue? value, BsRenderText? renderText, BsSetOptionValue? other}) {
    return BsSelectBoxResponse(
      options: map.map((e) {
        return BsSelectBoxOption(
          value: value == null ? e['value'] : value(e),
          text: renderText == null ? Text(e['text']) : renderText(e),
          other: other == null ? e : other(e),
        );
    }).toList());
  }
}
