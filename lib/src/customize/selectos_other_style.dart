import 'package:flutter/cupertino.dart';
import 'package:selectos/src/config/constants.dart' show DATA_NOT_FOUND, HINT, SEARCH;
import 'package:selectos/src/config/enums.dart';

class SelectosOtherStyle {

  const SelectosOtherStyle({
    this.notFoundText = DATA_NOT_FOUND,
    this.hintText = HINT,
    this.searchText = SEARCH,
    this.loadingStyle = LoadingStyle.linear,
    this.emptyIcon = const Icon(CupertinoIcons.search),
    this.loadingWidget,
    this.emptyWidget,
  });


  final String searchText;

  final String hintText;

  final String notFoundText;

  final LoadingStyle loadingStyle;

  final Icon emptyIcon;

  final Widget? loadingWidget;

  final Widget? emptyWidget;


}