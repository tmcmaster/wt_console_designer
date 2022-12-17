import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_providers.dart';

final moveResizeProvider = StateNotifierProvider<MoveResizeNotifier, Item?>(
  (ref) => MoveResizeNotifier(ref),
);

class MoveResizeNotifier extends StateNotifier<Item?> {
  final Ref ref;

  InteractionMode? mode;

  MoveResizeNotifier(this.ref) : super(null);

  void select(Item item, TapDownDetails details) {
    mode = _calculateMode(item.size, details.localPosition);

    state = item;
  }

  void update(DragUpdateDetails details, BoxConstraints constraints) {
    if (state != null) {
      final point = state!.point;
      final size = state!.size;
      if (mode == InteractionMode.moving) {
        final newPoint = Point(
          point.x + details.delta.dx,
          point.y + details.delta.dy,
        );
        if (_isWithinConstraints(constraints, newPoint, size)) {
          state = state!.copyWith(
            point: newPoint,
            highlighted: true,
          );
        }
      } else {
        final newSize = Size(
          size.width + details.delta.dx,
          size.height + details.delta.dy,
        );
        if (newSize.width > 0 &&
            newSize.height > 0 &&
            _isWithinConstraints(constraints, point, newSize)) {
          state = state!.copyWith(
            size: newSize,
            highlighted: true,
          );
        }
      }
      ref.read(itemListProvider.notifier).updateItem(state!);
    }
  }

  void resizeCanvasIfRequired() {
    if (state != null) {
      final size = ref.read(scrollPaneStateProvider).size;

      if ((state!.point.x + state!.size.width) > size.width ||
          (state!.point.y + state!.size.height) > size.height) {
        final newSize = Size(
          (state!.point.x + state!.size.width) > size.width
              ? state!.point.x + state!.size.width
              : size.width + 200,
          (state!.point.y + state!.size.height) > size.height
              ? state!.point.y + state!.size.height
              : size.height + 100,
        );
        ref.read(scrollPaneStateProvider.notifier).update(
              size: newSize,
            );
      }
    }
  }

  void unselect() {
    if (state != null) {
      ref.read(itemListProvider.notifier).updateItem(state!.copyWith(highlighted: false));
    }
    state = null;
    mode = null;
  }

  InteractionMode _calculateMode(Size size, Offset offset) {
    return ((size.width - offset.dx) < 20) && ((size.height - offset.dy) < 20)
        ? InteractionMode.resizing
        : InteractionMode.moving;
  }

  bool _isWithinConstraints(BoxConstraints constraints, Point point, Size size) {
    return point.x > 0 && point.y > 0;
    // return point.x > 0 &&
    //     (point.x + size.width) < constraints.maxWidth &&
    //     point.y > 0 &&
    //     (point.y + size.height) < constraints.maxHeight;
  }
}

enum InteractionMode {
  moving,
  resizing;
}
