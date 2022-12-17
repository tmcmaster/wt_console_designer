import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/drag_select.dart';
import 'package:wt_console_designer/designer/widgets/draggable_item_widget.dart';
import 'package:wt_console_designer/designer/widgets/selection_box.dart';

final stackKey = GlobalKey();

class DesignerStack extends ConsumerWidget {
  DesignerStack({Key? key}) : super(key: key);

  bool panMode = true;

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
          print(details.localPosition);
          moveResizeNotifier.update(details, constraints);
        },
        onPanEnd: (details) {
          moveResizeNotifier.unselect();
        },
        child: Stack(
          key: stackKey,
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
