import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';

class DragSelect extends ConsumerWidget {
  final void Function(Point) onSelect;
  final void Function(Point) onDrag;
  final void Function() onComplete;
  final BoxConstraints constraints;

  const DragSelect({
    super.key,
    required this.onSelect,
    required this.constraints,
    required this.onDrag,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);

    return Positioned(
      width: constraints.maxWidth,
      height: constraints.maxWidth,
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onHorizontalDragStart: (details) {
          final start = details.localPosition;
          onSelect(Point(start.dx, start.dy));
        },
        onHorizontalDragUpdate: (details) {
          final end = details.localPosition;
          onDrag(Point(end.dx, end.dy));
        },
        onHorizontalDragEnd: (details) {
          onComplete();
        },
        onTap: () {
          notifier.clearSelection();
        },
      ),
    );
  }
}
