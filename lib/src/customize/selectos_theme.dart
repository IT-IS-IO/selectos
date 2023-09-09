import 'package:selectos/src/customize/selectos_field_style.dart';
import 'package:selectos/src/customize/selectos_dialog_style.dart';
import 'package:selectos/src/customize/selectos_list_style.dart';
import 'package:selectos/src/customize/selectos_other_style.dart';


class SelectosTheme {


  const SelectosTheme({
    this.field = const SelectosFieldStyle(),
    this.list = const SelectosListStyle(),
    this.dialog = const SelectosDialogStyle(),
    this.other = const SelectosOtherStyle(),
  });

  final SelectosDialogStyle dialog;

  final SelectosFieldStyle field;

  final SelectosListStyle list;

  final SelectosOtherStyle other;

}

