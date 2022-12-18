import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_canvas.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_providers.dart';

final globalStackKey = GlobalKey();

class ScrollPane extends ConsumerWidget {
  final bool canScale;
  final Widget child;

  const ScrollPane({
    super.key,
    required this.child,
    this.canScale = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: LayoutBuilder(builder: (context, constraints) {
        // print(Size(constraints.minWidth, constraints.minHeight));
        Future.delayed(const Duration(microseconds: 1), () {
          ref.read(scrollPaneStateProvider.notifier).minSize(Size(
                constraints.minWidth,
                constraints.minHeight,
              ));
        });
        return Stack(
          key: globalStackKey,
          children: [
            ScrollPaneCanvas(
              canScale: canScale,
              child: child,
            ),
          ],
        );
      }),
    );
  }
}
