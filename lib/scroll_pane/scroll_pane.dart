import 'package:flutter/material.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_canvas.dart';

final globalStackKey = GlobalKey();

class ScrollPane extends StatelessWidget {
  final bool canScale;
  final Widget child;

  const ScrollPane({
    super.key,
    required this.child,
    this.canScale = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.yellow,
      child: Stack(
        key: globalStackKey,
        children: [
          ScrollPaneCanvas(
            canScale: canScale,
            child: child,
          ),
        ],
      ),
    );
  }
}
