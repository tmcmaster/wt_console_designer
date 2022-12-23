import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/item_widget_factory.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_logging/wt_logging.dart';

part 'scroll_pane_canvas.dart';
part 'scroll_pane_gesture_detector.dart';
part 'scroll_pane_interactive_mode.dart';
part 'scroll_pane_item_widget.dart';
part 'scroll_pane_notifier.dart';
part 'scroll_pane_select_box.dart';
part 'scroll_pane_selection_box.dart';
part 'scroll_pane_state.dart';

class ScrollPane extends ConsumerWidget {
  static final log = logger(ScrollPane, level: Level.verbose);
  final _key = GlobalKey();

  final bool panEnabled;
  final List<Widget> children;

  ScrollPane({
    super.key,
    this.panEnabled = false,
    required this.children,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('=== Building Widget.');

    final notifier = ref.read(scrollPaneStateProvider.notifier);

    ref.watch(itemCountProvider);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(0),
      child: LayoutBuilder(builder: (context, constraints) {
        Future.delayed(const Duration(milliseconds: 10), () {
          notifier.windowResize(constraints.minWidth, constraints.minHeight);
        });
        return Stack(
          key: _key,
          children: [
            ScrollPaneCanvas(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/paper-texture.png'),
                      // repeat: ImageRepeat.repeat,
                    ),
                  ),
                ),
                const DragAndPanDetector(
                  panEnabled: true,
                ),
                ...children,
              ],
            ),
            const ScrollPaneSelectionBox(),
          ],
        );
      }),
    );
  }
}
