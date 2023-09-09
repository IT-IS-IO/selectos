

import 'package:selectos/src/config/methods.dart';
import 'package:selectos/src/utils/selectos_option.dart';

class SelectosController {

  SelectosController({
    List<SelectosOption>? selected,
    this.processing = false,
    this.multiple = false,
    this.options = const [],
  }) : _selected = selected;

  bool processing;

  bool multiple;

  List<SelectosOption> options;

  List<SelectosOption>? _selected;

  void clear() { if (_selected != null) _selected = null; }

  void setOptions(List<SelectosOption> allOptions) => options = allOptions;

  void addOption(SelectosOption option) => options.add(option);

  void addOptionAll(List<SelectosOption> options) => options.addAll(options);

  void setSelected(SelectosOption option) {

    _selected ??= List<SelectosOption>.empty(growable: true);

    if (!multiple) _selected = [option];

    else if (multiple) _selected!.add(option);
  }

  void setSelectedAll(List<SelectosOption> options) => _selected = options;

  void removeSelectedAt(int index) {
    if (_selected != null) {
      _selected!.removeAt(index);

      if (_selected!.isEmpty) clear();
    }
  }

  void removeSelected(SelectosOption option) {
    if (_selected != null) {
      int index = _selected!
          .indexWhere((element) => element.getValue() == option.getValue());
      if (index != -1) _selected!.removeAt(index);

      if (_selected!.isEmpty) clear();
    }
  }

  SelectosOption? get getSelected =>  isNull(_selected) ? null : _selected!.first;

  List<SelectosOption> get getSelectedAll => isNull(_selected) ? [] : _selected!;

  String getSelectedAsString() {
    if (_selected != null) {
      StringBuffer string = StringBuffer();
      for (var option in _selected!) {
        string.write('${option.getValueAsString},');
      }

      return string.toString().isEmpty ? '' : string.toString().substring(0, string.toString().length - 1);
    }

    return '';
  }

}
