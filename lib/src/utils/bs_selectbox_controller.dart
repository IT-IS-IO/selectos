import '../../selectos.dart';

/// Class to controll [Selectos]
class BsSelectBoxController {
  /// Constructor [BsSelectBoxController]
  BsSelectBoxController({
    List<BsSelectBoxOption>? selected,
    this.processing = false,
    this.multiple = false,
    this.options = const [],
  }) : _selected = selected;

  /// define state of [Selectos] when using server side mode
  bool processing;

  /// define permission [Selectos] is allowed multiple choice or not
  bool multiple;

  /// define options of [Selectos]
  List<BsSelectBoxOption> options;

  /// define selected value with private
  List<BsSelectBoxOption>? _selected;

  /// to clear selected value of [Selectos]
  void clear() {
    if (_selected != null) _selected = null;
  }

  /// to set all options of [Selectos]
  void setOptions(List<BsSelectBoxOption> allOptions) => options = allOptions;

  /// to add option of [Selectos]
  void addOption(BsSelectBoxOption option) => options.add(option);

  /// to add all options of [Selectos] with array
  void addOptionAll(List<BsSelectBoxOption> options) => options.addAll(options);

  /// to set selected value of [Selectos]
  void setSelected(BsSelectBoxOption option) {

    if (_selected == null) _selected = List<BsSelectBoxOption>.empty(growable: true);

    if (!multiple) _selected = [option];

    else if (multiple) _selected!.add(option);
  }

  /// to set selected multiple value of [Selectos]
  void setSelectedAll(List<BsSelectBoxOption> options) => _selected = options;

  /// remove selected value with specific index
  void removeSelectedAt(int index) {
    if (_selected != null) {
      _selected!.removeAt(index);

      if (_selected!.length == 0) clear();
    }
  }

  /// remove selected value
  void removeSelected(BsSelectBoxOption option) {
    if (_selected != null) {
      int index = _selected!
          .indexWhere((element) => element.getValue() == option.getValue());
      if (index != -1) _selected!.removeAt(index);

      if (_selected!.length == 0) clear();
    }
  }

  /// get first selected value, this function used when [Selectos] not allowed multiple
  BsSelectBoxOption? getSelected() =>
      _selected != null ? _selected!.first : null;

  /// get all selected value, this function used when [Selectos] allowd multiple
  List<BsSelectBoxOption> getSelectedAll() => _selected != null ? _selected! : [];

  /// get selected value in string
  String getSelectedAsString() {
    if (_selected != null) {
      StringBuffer string = StringBuffer();
      _selected!.forEach((option) {
        string.write(option.getValueAsString() + ',');
      });

      return string.toString().length == 0 ? ''
          : string.toString().substring(0, string.toString().length - 1);
    }

    return '';
  }

}
