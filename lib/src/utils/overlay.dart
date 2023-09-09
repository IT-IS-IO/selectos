import 'package:flutter/material.dart';

/// Class to handle all overlay of [BsSelectBox]
class SelectosOverlay {

  /// define overlay entry of [BsSelectBox]
  static List<SelectosOverlayEntry> overlays = [];

  /// add overlay entry when selectbox opened
  static SelectosOverlayEntry add(OverlayEntry overlayEntry, VoidCallback close) {

    SelectosOverlayEntry bsOverlayEntry = SelectosOverlayEntry(overlays.length, close, overlayEntry);
    overlays.add(bsOverlayEntry);

    return bsOverlayEntry;
  }

  /// get spesific data overlay
  static SelectosOverlayEntry get(int index) => overlays[index];

  /// remove all opened overlay in context
  static void removeAll() {

    overlays.map((overlay) {
      overlay.overlayEntry.remove();
      overlay.close();
    }).toList();

    overlays.clear();
  }

}

/// Class overlay entry of [BsSelectBox]
class SelectosOverlayEntry {
  /// Constructor [SelectosOverlayEntry]
  const SelectosOverlayEntry(this.index, VoidCallback close, this.overlayEntry) : _close = close;

  /// index position of overlay entry
  final int index;

  final VoidCallback _close;

  /// overlay entry of context
  final OverlayEntry overlayEntry;

  /// Close callback
  void close() => _close();
}
