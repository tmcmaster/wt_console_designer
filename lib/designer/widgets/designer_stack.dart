import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/drag_select.dart';
import 'package:wt_console_designer/designer/widgets/draggable_item_widget.dart';
import 'package:wt_console_designer/designer/widgets/selection_box.dart';

class DesignerStack extends ConsumerWidget {
  const DesignerStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('DesignerStack.build');
    ref.watch(itemCountProvider);
    final itemList = ref.read(itemListProvider);
    final selectionNotifier = ref.read(selectionProvider.notifier);
    final moveResizeNotifier = ref.read(moveResizeProvider.notifier);

    return LayoutBuilder(builder: (_, constraints) {
      return GestureDetector(
        onPanUpdate: (details) {
          // print(details.localPosition);
          moveResizeNotifier.update(details, constraints);
        },
        onPanEnd: (details) {
          moveResizeNotifier.unselect();
        },
        child: Stack(
          children: [
            DragSelect(
              constraints: constraints,
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
            const SelectionBox(),
            ...itemList
                .map((item) => DraggableItemWidget(
                      key: ValueKey(item.id),
                      id: item.id,
                    ))
                .toList(),
            // ...itemList
            //     .map((item) => MovableStackItem(
            //           key: ValueKey(item.id),
            //           item: item,
            //           constraints: constraints,
            //         ))
            //     .toList(),
            // const DraggableItemWidget(id: '001'),
          ],
        ),
      );
    });
  }
}
