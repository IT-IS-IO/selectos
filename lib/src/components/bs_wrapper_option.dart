import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uved/presentation/widgets/external_plugins/bs_flutter_selectbox/bs_flutter_selectbox.dart';

/// Wrapper overlay of options
// ignore: must_be_immutable
class BsWrapperOptions extends StatefulWidget {
  /// Constructor of BsWrapperOptions
  BsWrapperOptions({
    Key? key,
    required this.controller,
    required this.containerKey,
    required this.link,
    required this.onChange,
    required this.onClose,
    this.containerMargin = EdgeInsets.zero,
    this.noDataText = 'По вашему запросу нечего не найдено!',
    this.placeholderSearch = 'Поиск',
    this.selectBoxStyle = const BsSelectBoxStyle(),
    this.selectBoxSize = const BsSelectBoxSize(),
    this.searchable = true,
    this.style = const BsDialogBoxStyle(),
    this.padding = const EdgeInsets.all(10.0),
    this.margin = const EdgeInsets.only(top: 2.0, bottom: 2.0),
    this.onSearch,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BsWrapperOptionsState();
  }

  /// define searchable of [BsSelectBox]
  final bool searchable;

  /// Used so that the overlay wrapper follows the select box
  final LayerLink link;

  /// define no data found text
  final String noDataText;

  /// placeholder search input
  final String placeholderSearch;

  /// To get updated size of [BsSelectBox]
  final GlobalKey<State> containerKey;

  /// define style of [BsWrapperOption] below of [BsSelectBox]
  final BsSelectBoxStyle selectBoxStyle;

  /// define size of [BsWrapperOption] below of [BsSelectBox]
  final BsSelectBoxSize selectBoxSize;

  /// define controller of [BsWrapperOption] below of [BsSelectBox]
  final BsSelectBoxController controller;

  /// define on search action of [BsWrapperOption] below of [BsSelectBox]
  final ValueChanged<String>? onSearch;

  /// define on change action of [BsWrapperOption] below of [BsSelectBox]
  final ValueChanged<BsSelectBoxOption> onChange;

  final VoidCallback onClose;

  final EdgeInsets containerMargin;

  final BsDialogBoxStyle style;

  final EdgeInsetsGeometry padding;

  final EdgeInsets margin;

  Function _update = () { };

  void update() => _update();

}

class _BsWrapperOptionsState extends State<BsWrapperOptions> {

  GlobalKey<State> _key = GlobalKey<State>();
  GlobalKey<State> _keyAll = GlobalKey<State>();

  late FocusNode _focusNode;
  late TextEditingController _controller;

  late Size _size;
  late Offset _offset;

  double _overlayTop = 0;
  double _overlayLeft = 0;
  double _overlayHeight = 0;
  double _overlayWidth = 0;

  Timer? _timer;

  bool _done = false;

  @override
  void initState() {

    _focusNode = FocusNode(onKey: (node, event) {
      if(event.logicalKey == LogicalKeyboardKey.escape)
        widget.onClose();

      return KeyEventResult.ignored;
    },);

    _focusNode.addListener(onFocus);
    _focusNode.requestFocus();

    _controller = TextEditingController();

    RenderBox renderBox = widget.containerKey.currentContext!.findRenderObject() as RenderBox;
    _size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);

    _overlayLeft = widget.margin.left;
    _overlayWidth = _size.width - (widget.margin.right + widget.margin.left);

    widget._update = () {
      _checkHeight();
    };
    super.initState();
  }

  void onFocus() => updateState(() {});

  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void doneTyping(dynamic value, ValueChanged<dynamic> callback) {
    if (_timer != null) _timer!.cancel();

    _timer = Timer(Duration(milliseconds: 300), () => callback(value));
  }

  void updateState(VoidCallback function) {
    if(mounted)
      setState(() {
        function();
      });
  }

  void _checkHeight() {
    Future.delayed(Duration(microseconds: BsSelectBoxConfig.timeDelay), () {
      /// Getting source size and offset from container toggle

      try {
        RenderBox renderBoxContainer = widget.containerKey.currentContext!.findRenderObject() as RenderBox;
        _size = renderBoxContainer.size;
        _offset = renderBoxContainer.localToGlobal(Offset.zero);

        RenderBox renderBoxAll = _keyAll.currentContext!.findRenderObject() as RenderBox;
        Size sizeAll = renderBoxAll.size;

        RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
        Size size = renderBox.size;
        Size screenSize = MediaQuery.of(context).size;

        _overlayHeight = size.height;
        _overlayTop = _size.height + widget.margin.bottom;

        Offset overlayMaxPosition = Offset(_offset.dx + _size.width + size.width, _offset.dy + _size.height + _overlayHeight);

        double topHeight = _offset.dy + _size.height - 10;
        double bottomHeight = screenSize.height - (_offset.dy + 10);

        if(overlayMaxPosition.dy > screenSize.height) {
          if (bottomHeight > topHeight) {
            if (bottomHeight > widget.selectBoxSize.maxHeight)
              _overlayHeight = widget.selectBoxSize.maxHeight;
            else
              _overlayHeight = bottomHeight;
          }

          else {
            if(size.height <= widget.selectBoxSize.maxHeight)
              _overlayHeight = size.height;
            else if (topHeight > widget.selectBoxSize.maxHeight)
              _overlayHeight = widget.selectBoxSize.maxHeight;
            else
              _overlayHeight = topHeight;

            _overlayTop = -sizeAll.height - widget.margin.top;
          }
        }

        else {
          if(size.height > widget.selectBoxSize.maxHeight)
            _overlayHeight = widget.selectBoxSize.maxHeight;
        }
      }
      catch(e) {
        /// TODO: Тут вылаезает ошибка Unexpected null value
      }

      updateState(() => _done = true);

    });
  }

  @override
  Widget build(BuildContext context) {
    _checkHeight();

    return Opacity(
      opacity: _done ? 1 : 0,
      child: Container(
        child: Stack(
          children: [

            GestureDetector(
              onTap: () {
                widget.onClose.call();
              },
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),

            Positioned(
              child: CompositedTransformFollower(
                link: widget.link,
                showWhenUnlinked: false,
                offset: Offset(_overlayLeft, _overlayTop),
                child: Column(
                  children: [
                    Material(
                      child: Container(
                        key: _keyAll,
                        width: _overlayWidth,
                        padding: widget.padding,
                        decoration: BoxDecoration(
                            color: widget.style.backgroundColor != null ? widget.style.backgroundColor : widget.selectBoxStyle.backgroundColor,
                            border: widget.style.border != null ? widget.style.border : widget.selectBoxStyle.border,
                            borderRadius: widget.style.borderRadius != null ? widget.style.borderRadius : widget.selectBoxStyle.borderRadius,
                            boxShadow: widget.style.boxShadow != null ? widget.style.boxShadow : [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(2.0, 2.0)
                              )
                            ]
                        ),
                        child: Column(
                          children: [
                            !widget.searchable ? Container() : Container(
                                margin: EdgeInsets.only(bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: widget.selectBoxStyle.searchColor,
                                  border: widget.selectBoxStyle.border,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: widget.placeholderSearch,
                                    hintStyle: TextStyle(
                                        color: widget.selectBoxStyle.searchTextColor,
                                        fontSize: widget.selectBoxSize.searchInputFontSize
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(12.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(
                                      color: widget.selectBoxStyle.searchTextColor
                                  ),
                                  onChanged: (value) => doneTyping(value, (value) {
                                    if (widget.onSearch != null)
                                      widget.onSearch!(value);
                                  }),
                                )
                            ),
                            !widget.controller.processing ? Container() : Center(
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Text("Memproses ...",
                                      style: TextStyle(
                                          color: widget.selectBoxStyle.textColor,
                                          fontSize: widget.selectBoxSize.optionFontSize,
                                          fontWeight: FontWeight.w100,
                                          fontStyle: FontStyle.italic
                                      )
                                  )
                              ),
                            ),
                            widget.controller.processing || widget.controller.options.length != 0 ? Container() : Center(
                              child: Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  padding: EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
                                  child: Text(widget.noDataText,
                                      style: TextStyle(
                                          color: widget.selectBoxStyle.textColor,
                                          fontSize: widget.selectBoxSize.optionFontSize,
                                          fontWeight: FontWeight.w100,
                                          fontStyle: FontStyle.italic
                                      )
                                  )
                              ),
                            ),
                            widget.controller.processing || widget.controller.options.length == 0 ? Container(key: _key) : Container(
                              key: _key,
                              height: _overlayHeight == 0 ? null : _overlayHeight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: widget.selectBoxSize.maxHeight),
                                child: SingleChildScrollView(
                                  primary: false,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: widget.controller.options.map((option) {
                                      Color textColor = widget.style.itemTextColor != null ? widget.style.itemTextColor! : widget.selectBoxStyle.textColor;
                                      Color backgroundColor = widget.style.itemColor != null ? widget.style.itemColor! : widget.selectBoxStyle.backgroundColor;

                                      if (widget.controller.getSelected() != null) {
                                        int index = widget.controller.getSelectedAll().indexWhere((element) => element.getValue() == option.getValue());

                                        if (index != -1) {
                                          backgroundColor = widget.selectBoxStyle.selectedColor;
                                          textColor = widget.selectBoxStyle.selectedTextColor;
                                        }
                                      }

                                      return Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: 2.0),
                                                child: Material(
                                                  color: backgroundColor,
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      widget.onChange(option);
                                                      _focusNode.unfocus();
                                                      updateState(() {});
                                                    },
                                                    child: DefaultTextStyle(
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: widget.selectBoxSize.optionFontSize
                                                      ),
                                                      child: Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
                                                        child: option.getText(),
                                                      ),
                                                    ),
                                                    borderRadius: BorderRadius.circular(5.0),
                                                    splashColor: widget.selectBoxStyle.selectedColor,
                                                    highlightColor: widget.selectBoxStyle.selectedColor,
                                                  ),
                                                ),
                                              )
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


}
