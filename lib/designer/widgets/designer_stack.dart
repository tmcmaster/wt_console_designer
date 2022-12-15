import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/drag_select.dart';
import 'package:wt_console_designer/designer/widgets/movable_stack_item.dart';
import 'package:wt_console_designer/designer/widgets/selection_box.dart';

class DesignerStack extends ConsumerWidget {
  const DesignerStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemList = ref.watch(itemListProvider);
    final selectionNotifier = ref.watch(selectionProvider.notifier);

    return LayoutBuilder(builder: (_, constraints) {
      return Stack(
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
              .map((item) => MovableStackItem(
                    key: ValueKey(item.id),
                    item: item,
                    constraints: constraints,
                  ))
              .toList(),
        ],
      );
    });
  }
}
