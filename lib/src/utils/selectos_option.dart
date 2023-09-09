import 'package:flutter/cupertino.dart';

class SelectosOption {

  const SelectosOption({
    required dynamic value,
    required Widget text,
    String? searchable,
    dynamic other,
  }) : _searchable = searchable,
        _value = value,
        _text = text,
        _other = other;

  final dynamic _value;

  final Widget _text;

  final dynamic _other;

  final String? _searchable;

  Widget get getText => _text;

  dynamic get getValue => _value;

  dynamic get getOtherValue => _other;

  String get getValueAsString => _value.toString();

  String get searchable => _searchable != null ? _searchable! : getValueAsString;

  factory SelectosOption.fromJson(Map<String, dynamic> json) {
    return SelectosOption(
      value: json['value'],
      text: Text(json['text']),
      searchable: json['searchable'],
      other: json['other'],
    );
  }


}
