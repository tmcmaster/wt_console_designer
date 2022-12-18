import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';

class DraggableItemWidget extends ConsumerWidget {
  static const debug = false;

  final String id;

  const DraggableItemWidget({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('DraggableItemWidget($id).build');
    final item = ref.watch(itemProvider(id));
    final moveResizeNotifier = ref.read(moveResizeProvider.notifier);
    final itemListNotifier = ref.read(itemListProvider.notifier);

    return item == null
        ? Container()
        : Positioned(
            left: item.point.x.toDouble(),
            top: item.point.y.toDouble(),
            child: GestureDetector(
              onDoubleTap: () {
                // print('Bring to front ${item.id}');
                itemListNotifier.bringToFront(item);
              },
              onTapDown: (details) {
                // print('Selected Item: ${item.id}');
                moveResizeNotifier.select(item, details);
                if (item.selected) {
                  itemListNotifier.updateItem(item.copyWith(selected: false));
                }
              },
              onLongPress: () {
                itemListNotifier.updateItem(item.copyWith(selected: true));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: item.selected
                      ? Border.all(color: Colors.black, width: 2)
                      : Border.all(color: Colors.grey, width: 1),
                  color: item.color,
                  boxShadow: [
                    if (item.highlighted)
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 10,
                        blurRadius: 15,
                        // offset: const Offset(10, 10), // changes position of shadow
                      ),
                  ],
                ),
                width: item.size.width,
                height: item.size.height,
                child: debug && item.size.width > 100 && item.size.height > 40
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Pos(${item.point.x.toInt()},${item.point.y.toInt()})'),
                          Text('Size(${item.size.width.toInt()}, ${item.size.height.toInt()})'),
                        ],
                      )
                    : Container(
                        child: Center(
                        child: Text(
                          'Placeholder ${capitalize(item.type.name)}',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                      )),
              ),
            ),
          );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
