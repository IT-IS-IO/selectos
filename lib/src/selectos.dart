import 'package:bs_flutter_utils/bs_flutter_utils.dart';
import 'package:flutter/material.dart';
import 'package:selectos/selectos.dart';
import 'package:selectos/src/addons/selectos_wrapper_option.dart';
import 'package:selectos/src/config/methods.dart';
import 'package:selectos/src/customize/selectos_theme.dart';
import 'package:selectos/src/utils/ui.dart';


class Selectos extends StatefulWidget {

  const Selectos({
    Key? key,
    this.controller,
    this.focusNode,
    this.onRemove,
    this.onChange,
    this.onClear,
    this.onClose,
    this.onOpen,
    this.remote,
    this.title,
    this.hintText,
    this.validators = const [],
    this.disabled = false,
    this.searchable = false,
    this.autoClose = true,
    this.theme = const SelectosTheme(),
  }) : super(key: key);


  final SelectosTheme theme;

  final SelectosController? controller;

  final FocusNode? focusNode;

  final RemoteRecord? remote;

  final String? hintText;

  final String? title;

  final bool searchable;

  final bool disabled;

  final bool autoClose;

  final List<dynamic> validators;

  final ChangeValue? onRemove;

  final ChangeValue? onChange;

  final VoidCallback? onClear;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;


  @override
  State<StatefulWidget> createState() => _SelectosState();

}



class _SelectosState extends State<Selectos> {


  late final SelectosController _controller = widget.controller ?? SelectosController();

  SelectosTheme get _theme => widget.theme;
  SelectosFieldStyle get fdStyle => _theme.field;


  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyOverlay = GlobalKey<State>();

  Duration duration = const Duration(milliseconds: 100);

  late FocusNode _focusNode;

  final LayerLink _layerLink = LayerLink();
  late List<SelectosOption> _options;

  late FormFieldState formFieldState;

  SelectosWrapperOptions? _wrapperOptions;

  bool isOpen = false;



  @override
  void initState() {
    super.initState();

    _focusNode = (isNull(widget.focusNode) ? FocusNode() : widget.focusNode!)..addListener(onFocus);
    _options = _controller.options;

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool returned = true;
        if(isOpen) {
          returned = false;
          _close();
        }
        return returned;
      },
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: emptyToNull(_controller.getSelectedAsString()),
        validator: (value) {

          SelectosOption? option = _controller.getSelected;

          for (var validator in widget.validators) {
            final error = validator(option);
            if (isNotNull(error)) return error;
          }

          return null;

        },
        builder: (FormFieldState<String> field) {

          Future.delayed(const Duration(milliseconds: 100), () {
            if (field.mounted && _controller.getSelectedAsString().isNotEmpty)
              field.didChange(_controller.getSelectedAsString());
          });

          formFieldState = field;

          var border = fdStyle.border;
          var boxShadow = fdStyle.focusedBoxShadow;

          if (isOpen) {
            border = fdStyle.focusedBorder;
          }

          if (field.hasError) {
            border = Border.all(color: const Color.fromRGBO(255, 0, 0, 1));
            boxShadow = const [
              BoxShadow(
                color: Color.fromRGBO(255, 0, 0, 0.25),
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ];
          }

          return Column(
            children: [

              if (isNotNull(widget.title))
                Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF8E8E93)
                    ),
                  ),
                ),

              Stack(
                clipBehavior: Clip.none,
                children: [

                  renderContainer(
                    valid: !field.hasError,
                    border: border,
                    boxShadow: boxShadow,
                    onChange: (value) => field.didChange(value),
                  ),

                ],
              ),

              if (field.hasError)
                Container(
                  margin: const EdgeInsets.only(top: 5.0, left: 2.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    field.errorText!,
                    style: const TextStyle(
                        fontSize: 12.0,
                        color: BsColor.textError
                    ),
                  ),
                ),

            ],
          );
        },
        onSaved: (value) {
          formFieldState.didChange(value);
          formFieldState.validate();
        },
      ),
    );
  }

  Widget renderContainer({ required bool valid, required ValueChanged<String> onChange, BoxBorder? border, List<BoxShadow> boxShadow = const [] }) {

    return CompositedTransformTarget(
      link: _layerLink,
      key: _key,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: _theme.field.inputMaxHeight,
          maxHeight: _theme.field.inputMinHeight,
        ),
        child: TextButton(
          focusNode: _focusNode,
          onPressed: _onPressed,
          style: TextButton.styleFrom( padding: EdgeInsets.zero, minimumSize: const Size(10.0, 10.0)),
          child: DefaultTextStyle(
            style: TextStyle( color: fdStyle.textColor ),
            child: Container(
              decoration: BoxDecoration(
                  color: widget.disabled ? fdStyle.disabledColor : fdStyle.backgroundColor,
                  border: border,
                  borderRadius: fdStyle.borderRadius,
                  boxShadow: boxShadow
              ),
              constraints: BoxConstraints(
                minHeight: _theme.field.inputMaxHeight,
                maxHeight: _theme.field.inputMinHeight,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [

                  Expanded(
                      child: _controller.getSelectedAll.isEmpty
                          ? SelectosUiUtils.generateHintWidget(widget.hintText, valid, fdStyle)
                          : renderSelected()
                  ),

                  if (isNotNull(_controller.getSelected))
                    Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      child: IconButton(
                        onPressed: _clear,
                        icon: Icon(
                          fdStyle.clearIcon,
                          size: fdStyle.iconSize,
                          color: Colors.grey,
                        ),
                      ),
                    ),


                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      fdStyle.arrowIcon,
                      size: fdStyle.iconSize,
                      color: Colors.grey,
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget renderSelected() {
    List<Widget> children = [];
    if (!_controller.multiple)
      children.add(DefaultTextStyle(
        style: TextStyle(
          fontSize: fdStyle.fontSize,
          color: fdStyle.selectedTextColor,
        ),
        child: Container(child: _controller.getSelected!.getText),
      ));

    if (_controller.multiple)
      for (var option in _controller.getSelectedAll) {
        children.add(Container(
            margin: const EdgeInsets.only(right: 5.0, bottom: 1.0, top: 1.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {

                  if (_keyOverlay.currentState != null &&

                      _keyOverlay.currentState!.mounted)
                    _keyOverlay.currentState!.setState(() {});

                  _controller.removeSelected(option);

                  if(widget.onRemove != null)
                    widget.onRemove!(option);

                  formFieldState.didChange(_controller.getSelectedAsString());

                  _updateState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  decoration: BoxDecoration(
                    color: _theme.field.selectedColor,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: DefaultTextStyle(
                            style: TextStyle(
                              fontSize: _theme.field.fontSize - 2,
                              color: _theme.field.selectedTextColor,
                            ),
                            child: option.getText,
                          )
                      ),

                      const Icon(Icons.close),

                    ],
                  ),
                ),
              ),
            )
        ));
      }

    return Wrap(children: children);
  }


  void onFocus() {
    if (_focusNode.hasFocus && !widget.disabled) _open();
  }


  void _updateState(VoidCallback fn) {
    if(mounted) setState(fn);
  }


  void _onPressed() {
    if (!widget.disabled) {
      if (!isOpen) _open();
      else _close();
    }
  }


  void _open() {

    SelectosOverlay.removeAll();

    _wrapperOptions = SelectosWrapperOptions(
      key: _keyOverlay,
      theme: _theme,
      link: _layerLink,
      containerKey: _key,
      searchable: widget.searchable,
      controller: _controller,
      onClose: () => _close(),
      onChange: (option) {

        if (_controller.multiple) {

          if (_controller.getSelected != null) {

            int index = _controller.getSelectedAll.indexWhere((element) => element.getValue == option.getValue);

            if (index != -1) _controller.removeSelectedAt(index);
            else _controller.setSelected(option);

          } else _controller.setSelected(option);

          _updateState(() {});
        }

        if (!_controller.multiple) {
          _controller.setSelected(option);
        }

        if(widget.autoClose) _close();

        widget.onChange?.call(option);

        _updateState(() { });

        formFieldState.didChange(option.getValueAsString);

        _wrapperOptions?.update();

      },
      onSearch: (String value) async {

        if (isNotNull(widget.remote)) _api(query: value);
        else {

          _controller.options = _options.where((element) => value.isEmpty || element.searchable.contains(value)).toList();

          if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
            _keyOverlay.currentState!.setState(() {});

          _wrapperOptions?.update();

          _updateState(() { });
        }



      },
    );

    if (isNotNull(widget.remote)) _api();

    SelectosOverlayEntry overlayEntry = SelectosOverlay.add(OverlayEntry(builder: (context) =>  _wrapperOptions!), () => _updateState(() => isOpen = false));

    Overlay.of(context).insert(overlayEntry.overlayEntry);

    widget.onOpen?.call();

    _updateState(() => isOpen = true);

  }


  void _close() {

    SelectosOverlay.removeAll();

    widget.onClose?.call();

    _updateState(() => isOpen = false);
  }


  void _clear() {

    SelectosOverlay.removeAll();

    _controller.clear();

    formFieldState.didChange(_controller.getSelectedAsString());

    widget.onClear?.call();

    _updateState(() => _focusNode.requestFocus());
  }


  void _api({ String query = '' }) {

      _controller.processing = true;

      _keyOverlay.currentState?.setState(() {});

      widget.remote?.call(query: query).then((response) {
        _controller.processing = false;
        _controller.options = response.options;
        _wrapperOptions?.update();
        _updateState(() { });
    });

  }



  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }


}
