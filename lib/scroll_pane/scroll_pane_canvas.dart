import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane.dart';
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

    if (globalStackKey.currentState != null) {
      print(globalStackKey.currentState!.context.size);
    }

    final state = ref.watch(scrollPaneStateProvider);
    final notifier = ref.read(scrollPaneStateProvider.notifier);

    return Positioned(
      left: state.offset.dx,
      top: state.offset.dy,
      child: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
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
              final box = globalStackKey.currentContext?.findRenderObject() as RenderBox;
              final offset = box.localToGlobal(Offset.zero);
              final size = box.size;

              if (size.width > state.size.width || size.height > state.size.height) {
                notifier.update(
                    size: Size(
                  size.width > state.size.width ? size.width : state.size.width,
                  size.height > state.size.height ? size.height : state.size.height,
                ));
              }

              final newX = details.focalPoint.dx - start.dx - offset.dx;
              final newY = details.focalPoint.dy - start.dy - offset.dy;

              if (newX < 0 || newY < 0) {
                notifier.update(
                  offset: Offset(
                    newX < 0 && (newX + state.size.width) > (size.width) ? newX : state.offset.dx,
                    newY < 0 && (newY + state.size.height) > (size.height) ? newY : state.offset.dy,
                  ),
                );
              }

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
              width: state.size.width,
              height: state.size.height,
              decoration: const BoxDecoration(
                color: Colors.purple,
                // border: Border.all(
                //   color: Colors.grey.shade500,
                //   width: 5,
                // ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: widget.child,
              ),
            ),
          ),
        );
      }),
    );
  }
}
