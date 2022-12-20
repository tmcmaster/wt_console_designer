import 'dart:math';

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

class ScrollPane extends ConsumerStatefulWidget {
  ScrollPane({super.key});

  @override
  ConsumerState<ScrollPane> createState() => _ScrollPaneState();
}

class _ScrollPaneState extends ConsumerState<ScrollPane> {
  static final log = logger(ScrollPane, level: Level.debug);

  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log.d('=== Building Widget.');

    final notifier = ref.read(scrollPaneStateProvider.notifier);
    final selection = ref.read(selectionProvider.notifier);

    final itemsNotifier = ref.read(itemListProvider.notifier);
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
                IgnorePointer(
                  child: Container(
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
                ),
                DragAndPanDetector(
                  onDeselect: () {
                    itemsNotifier.clearSelection();
                  },
                  onSelecting: (region) {
                    log.d('Selecting: $region');
                    selection.setRegion(region);
                  },
                  onSelected: (region) {
                    log.d('Selected: $region');
                    selection.end();
                    selection.clear();
                  },
                  onPanning: (offset) {
                    log.v('Panning: $offset');
                    notifier.movePoint(offset);
                  },
                ),
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
