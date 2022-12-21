import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';
import 'package:wt_console_designer/scroll_pane_2/scroll_pane_item_widget.dart';
import 'package:wt_logging/wt_logging.dart';

part 'scroll_pane_canvas.dart';
part 'scroll_pane_gesture_detector.dart';
part 'scroll_pane_notifier.dart';
part 'scroll_pane_select_box.dart';
part 'scroll_pane_selection_box.dart';
part 'scroll_pane_state.dart';

class ScrollPane extends ConsumerWidget {
  static final log = logger(ScrollPane, level: Level.debug);
  final _key = GlobalKey();

  ScrollPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('=== Building Widget.');

    final notifier = ref.read(scrollPaneStateProvider.notifier);
    final items = ref.read(itemListProvider);

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
                const DragAndPanDetector(),
                ...items.map((item) {
                  log.d('Building item ${item.id}');
                  return ScrollPaneItemWidget(id: item.id);
                }).toList(),
              ],
            ),
            const ScrollPaneSelectionBox(),
          ],
        );
      }),
    );
  }
}
