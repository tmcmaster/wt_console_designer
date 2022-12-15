import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';

final selectionProvider = StateNotifierProvider<SelectionStateNotifier, Rectangle?>(
  (ref) => SelectionStateNotifier(ref),
);

class SelectionStateNotifier extends StateNotifier<Rectangle?> {
  final Ref ref;
  Point? _start;
  Point? _end;

  SelectionStateNotifier(this.ref) : super(null);

  void start(Point point) {
    _start = point;
  }

  void drag(Point point) {
    if (_start != null) {
      final x = point.x - _start!.x;
      final y = point.y - _start!.y;
      _end = Point(x, y);
      if (_start != null && _end != null) {
        state = Rectangle(_start!.x, _start!.y, _end!.x, _end!.y);
      }
    }
  }

  void end() {
    if (state != null) {
      ref.read(itemListProvider.notifier).selectInRegion(state!);
    }
    clear();
  }

  void clear() {
    _start = null;
    _end = null;
    state = null;
  }
}
