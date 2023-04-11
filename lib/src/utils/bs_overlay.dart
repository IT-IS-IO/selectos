import 'package:flutter/material.dart';

/// Class to handle all overlay of [BsSelectBox]
class SelectBoxOverlay {
  /// define overlay entry of [BsSelectBox]
  static List<SelectBoxOverlayEntry> overlays = [];

  /// add overlay entry when selectbox opened
  static SelectBoxOverlayEntry add(OverlayEntry overlayEntry, VoidCallback close) {
    SelectBoxOverlayEntry bsOverlayEntry = SelectBoxOverlayEntry(overlays.length, close, overlayEntry);
    overlays.add(bsOverlayEntry);

    return bsOverlayEntry;
  }

  /// get spesific data overlay
  static SelectBoxOverlayEntry get(int index) {
    return overlays[index];
  }

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
class SelectBoxOverlayEntry {
  /// Constructor [SelectBoxOverlayEntry]
  const SelectBoxOverlayEntry(this.index, VoidCallback close, this.overlayEntry)
      : _close = close;

  /// index position of overlay entry
  final int index;

  final VoidCallback _close;

  /// overlay entry of context
  final OverlayEntry overlayEntry;

  /// Close callback
  void close() => _close();
}
