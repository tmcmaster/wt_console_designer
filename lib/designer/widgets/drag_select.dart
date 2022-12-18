import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_logging/wt_logging.dart';

class DragSelect extends ConsumerStatefulWidget {
  final void Function() onPan;
  final void Function(Point) onSelect;
  final void Function(Point) onDrag;
  final void Function() onComplete;
  final BoxConstraints constraints;

  const DragSelect({
    super.key,
    required this.onPan,
    required this.onSelect,
    required this.constraints,
    required this.onDrag,
    required this.onComplete,
  });

  @override
  ConsumerState<DragSelect> createState() => _DragSelectState();
}

class _DragSelectState extends ConsumerState<DragSelect> {
  static final log = logger(DragSelect, level: Level.warning);
  bool selecting = false;

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    final notifier = ref.read(itemListProvider.notifier);
    final selectionNotifier = ref.read(selectionProvider.notifier);

    return Positioned(
      width: widget.constraints.maxWidth,
      height: widget.constraints.maxWidth,
      child: GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onDoubleTap: () {
          // This is required for the onDoubleTapDown to work
        },
        onDoubleTapDown: (details) {
          setState(() {
            selecting = true;
            selectionNotifier.start(Point(
              details.localPosition.dx,
              details.localPosition.dy,
            ));
          });
        },
        onPanStart: selecting
            ? (details) {
                selectionNotifier.start(Point(
                  details.localPosition.dx,
                  details.localPosition.dy,
                ));
              }
            : null,
        onPanUpdate: selecting
            ? (details) {
                selectionNotifier.drag(Point(
                  details.localPosition.dx,
                  details.localPosition.dy,
                ));
              }
            : null,
        onPanEnd: selecting
            ? (details) {
                setState(() {
                  selectionNotifier.end();
                  selecting = false;
                });
              }
            : null,
        onTap: () {
          notifier.clearSelection();
        },
      ),
    );
  }
}
