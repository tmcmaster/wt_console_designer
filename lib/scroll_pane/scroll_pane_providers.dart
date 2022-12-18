import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_state.dart';

final scrollPaneStateProvider = StateNotifierProvider<ScrollPaneStateNotifier, ScrollPaneState>(
  (ref) => ScrollPaneStateNotifier(),
);

class ScrollPaneStateNotifier extends StateNotifier<ScrollPaneState> {
  ScrollPaneStateNotifier()
      : super(ScrollPaneState(
          offset: const Offset(0, 0),
          size: const Size(500, 500),
          scale: 1,
          scaleDelta: 1,
        ));

  void update({
    Offset? offset,
    Size? size,
    double? scale,
    double? scaleDelta,
  }) {
    state = state.copyWith(
      offset: offset,
      size: size,
      scale: scale,
      scaleDelta: scaleDelta,
    );
  }

  void resizeIfNeedBe(Size screenSize) {
    if (state.size.width < screenSize.width || state.size.height < screenSize.height) {
      final newSize = Size(
        state.size.width < screenSize.width ? screenSize.width + 100 : state.size.width,
        state.size.height < screenSize.height ? screenSize.height : state.size.height,
      );
      // print('Resizing canvas to $newSize');
      state.copyWith(size: newSize);
    }
  }

  void minSize(Size size) {
    if (size.width > state.size.width || size.height > state.size.height) {
      update(
          size: Size(
        size.width > state.size.width ? size.width : state.size.width,
        size.height > state.size.height ? size.height : state.size.height,
      ));
    }
  }
}
