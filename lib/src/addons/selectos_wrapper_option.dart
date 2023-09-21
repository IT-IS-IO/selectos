import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selectos/selectos.dart';
import 'package:selectos/src/addons/empty_widget.dart';
import 'package:selectos/src/addons/loading_widget.dart';
import 'package:selectos/src/config/constants.dart';
import 'package:selectos/src/config/methods.dart';
import 'package:selectos/src/customize/selectos_list_style.dart';
import 'package:selectos/src/customize/selectos_theme.dart';


// ignore: must_be_immutable
class SelectosWrapperOptions extends StatefulWidget {

  SelectosWrapperOptions({
    Key? key,
    required this.controller,
    required this.containerKey,
    required this.link,
    required this.onChange,
    required this.onSearch,
    required this.onClose,
    required this.theme,
    this.searchable = true,
  }) : super(key: key);


  final bool searchable;

  final LayerLink link;

  final SelectosTheme theme;

  final GlobalKey<State> containerKey;

  final SelectosController controller;

  final VoidCallback onClose;

  final ValueChanged<String>? onSearch;

  final ChangeValue onChange;

  Function _update = () { };

  void update() => _update();

  @override
  State<StatefulWidget> createState() => _SelectosWrapperOptionsState();

}

class _SelectosWrapperOptionsState extends State<SelectosWrapperOptions> {

  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyAll = GlobalKey<State>();

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  static const MARGIN = EdgeInsets.all(0);

  late Size _size;
  late Offset _offset;

  double _overlayTop = 0;
  double _overlayLeft = 0;
  double _overlayHeight = 0;
  double _overlayWidth = 0;

  Timer? _timer;
  bool _done = false;


  SelectosDialogStyle get dgStyle => widget.theme.dialog;
  SelectosListStyle get ltStyle => widget.theme.list;
  SelectosFieldStyle get fdStyle => widget.theme.field;


  @override
  void initState() {
    super.initState();

    _focusNode
      // ..onKey = (_, event) {
      //   if(event.logicalKey == LogicalKeyboardKey.escape) widget.onClose();
      //   return KeyEventResult.ignored;
      // }
      .addListener(_onFocus);


    RenderBox renderBox = widget.containerKey.currentContext!.findRenderObject() as RenderBox;
    _size = renderBox.size;
    _offset = renderBox.localToGlobal(Offset.zero);

    _overlayLeft = MARGIN.left;
    _overlayWidth = _size.width - (MARGIN.right + MARGIN.left);

    widget._update = () => _checkHeight();

  }


  @override
  Widget build(BuildContext context) {
    _checkHeight();

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 120),
      opacity: _done ? 1.0 : 0.0,
      child: Stack(
        children: [

          GestureDetector(
            onTap: () => widget.onClose(),
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
              child: Material(
                child: Container(
                  key: _keyAll,
                  width: _overlayWidth,
                  decoration: dgStyle.decoration?.copyWith(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 18), // changes position of shadow
                      ),
                    ]
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      if (widget.searchable)
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: fdStyle.inputMaxHeight,
                            minHeight: fdStyle.inputMinHeight,
                          ),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _controller,
                            decoration: fdStyle.decoration,
                            selectionHeightStyle: BoxHeightStyle.max,
                            onChanged: (value) => _doneTyping(value, (value) { widget.onSearch?.call(value); }),
                          )
                        ),

                      if (widget.controller.processing)const LoadingAddon()
                      else const SizedBox(height: 4),

                      if (!widget.controller.processing && widget.controller.options.isEmpty) const EmptyAddon(),

                      if (!widget.controller.processing || widget.controller.options.isNotEmpty) ...[
                        Container(
                          key: _key,
                          constraints: BoxConstraints(
                            maxHeight: dgStyle.maxHeight,
                          ),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: widget.controller.options.length,
                            physics: ltStyle.physics,
                            primary: false,
                            itemBuilder: (_, index) {
                              SelectosOption option = widget.controller.options[index];
                              return Material(
                                child: InkWell(
                                  onTap: () {
                                    widget.onChange(option);
                                    _focusNode.unfocus();
                                    _updateState(() {});
                                  },
                                  child: Padding(
                                    padding: ltStyle.padding,
                                    child: Row(
                                      children: [

                                        Flexible(child: option.getText),

                                        // ...widget.actions.map((e) => IconButton(
                                        //     onPressed: () {
                                        //       e.onTap(option);
                                        //       _focusNode.unfocus();
                                        //       widget.onClose.call();
                                        //       updateState(() {});
                                        //     },
                                        //     icon: e.icon
                                        //   ),
                                        // ),

                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => ltStyle.divider,
                          ),
                        )
                      ]
                      else SizedBox(key: _key)

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }


  void _checkHeight() {
    Future.delayed(const Duration(microseconds: TIME_DELAY), () {

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
        _overlayTop = _size.height + MARGIN.bottom;

        Offset overlayMaxPosition = Offset(_offset.dx + _size.width + size.width, _offset.dy + _size.height + _overlayHeight);

        double topHeight = _offset.dy + _size.height - 10;
        double bottomHeight = screenSize.height - (_offset.dy + 10);

        if(overlayMaxPosition.dy > screenSize.height) {

          if (bottomHeight > topHeight) {
            if (bottomHeight > dgStyle.maxHeight) _overlayHeight = dgStyle.maxHeight;
            else _overlayHeight = bottomHeight;
          }
          else {

            if(size.height <= dgStyle.maxHeight) _overlayHeight = size.height;
            else if (topHeight > dgStyle.maxHeight) _overlayHeight = dgStyle.maxHeight;
            else _overlayHeight = topHeight;

            _overlayTop = -sizeAll.height - MARGIN.top;
          }

        }
        else if (size.height > dgStyle.maxHeight) {
            _overlayHeight = dgStyle.maxHeight;
        }

      }
      catch(e) {
        /// TODO: Тут вылаезает ошибка Unexpected null value
      }

      _updateState(() => _done = true);

    });
  }


  void _onFocus() => _updateState(() {});


  void _updateState(VoidCallback fn) { if(mounted) setState(fn); }


  void _doneTyping(dynamic value, ValueChanged<dynamic> callback) {
    if (isNotNull(_timer)) _timer!.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () => callback(value));
  }


  @override
  void dispose() {
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }


}
