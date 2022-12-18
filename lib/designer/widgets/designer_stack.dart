import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/drag_select.dart';
import 'package:wt_console_designer/designer/widgets/draggable_item_widget.dart';
import 'package:wt_console_designer/designer/widgets/selection_box.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane_providers.dart';
import 'package:wt_logging/wt_logging.dart';

final stackKey = GlobalKey();

class DesignerStack extends ConsumerWidget {
  static final log = logger(DesignerStack, level: Level.warning);

  DesignerStack({super.key});

  bool panMode = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');

    ref.watch(itemCountProvider);
    final itemList = ref.read(itemListProvider);
    final selectionNotifier = ref.read(selectionProvider.notifier);
    final moveResizeNotifier = ref.read(moveResizeProvider.notifier);

    return LayoutBuilder(builder: (_, constraints) {
      ref.read(scrollPaneStateProvider.notifier).resizeIfNeedBe(MediaQuery.of(context).size);

      return GestureDetector(
        onPanUpdate: (details) {
          log.v('onPanUpdate: $details');
          moveResizeNotifier.update(details, constraints);
        },
        onPanEnd: (details) {
          log.v('onPanEnd: $details');
          moveResizeNotifier.resizeCanvasIfRequired();
          moveResizeNotifier.unselect();
        },
        child: Stack(
          key: stackKey,
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
            DragSelect(
              constraints: constraints,
              onPan: () {},
              onSelect: (point) {
                selectionNotifier.start(point);
              },
              onDrag: (point) {
                selectionNotifier.drag(point);
              },
              onComplete: () {
                selectionNotifier.end();
              },
            ),
            ...itemList
                .map((item) => DraggableItemWidget(
                      key: ValueKey(item.id),
                      id: item.id,
                    ))
                .toList(),
            const SelectionBox(),
          ],
        ),
      );
    });
  }
}
