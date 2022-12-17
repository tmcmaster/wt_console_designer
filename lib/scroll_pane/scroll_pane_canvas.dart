import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_providers.dart';

class ScrollPaneCanvas extends ConsumerStatefulWidget {
  final Widget child;
  final bool canScale;

  const ScrollPaneCanvas({
    super.key,
    required this.child,
    this.canScale = false,
  });

  @override
  ConsumerState<ScrollPaneCanvas> createState() => _ScrollPaneCanvasState();
}

class _ScrollPaneCanvasState extends ConsumerState<ScrollPaneCanvas> {
  Offset start = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    // print('Building _ScrollPaneCanvasState');

    final state = ref.watch(scrollPaneStateProvider);
    final notifier = ref.read(scrollPaneStateProvider.notifier);

    return Positioned(
      left: state.offset.dx,
      top: state.offset.dy,
      child: GestureDetector(
        onScaleStart: (details) {
          start = details.localFocalPoint;
          //print('Start(${start.dx},${start.dy})');
        },
        onScaleEnd: (details) {
          if (widget.canScale) {
            notifier.update(
              scale: state.scale * state.scaleDelta,
              scaleDelta: 1,
            );
          }
        },
        onScaleUpdate: (details) {
          if (details.pointerCount == 1) {
            notifier.update(
              offset: Offset(
                details.focalPoint.dx - start.dx - 30,
                details.focalPoint.dy - start.dy - 30,
              ),
            );
            // print(state);
          } else if (widget.canScale) {
            notifier.update(
              scaleDelta: details.scale,
            );
            // print('Scale(${details.scale})');
          }
        },
        child: Transform.scale(
          scale: state.scale * state.scaleDelta,
          child: Container(
            width: 1000,
            height: 1000,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.purple,
              border: Border.all(
                color: Colors.grey.shade500,
                width: 5,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
