import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';
import 'package:wt_logging/wt_logging.dart';

class ScrollPaneItemWidget extends ConsumerStatefulWidget {
  static const debug = false;

  final String id;

  const ScrollPaneItemWidget({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ScrollPaneItemWidget> createState() => _DraggableItemWidget2State();
}

class _DraggableItemWidget2State extends ConsumerState<ScrollPaneItemWidget> {
  static final log = logger(ScrollPaneItemWidget, level: Level.warning);

  Offset? point;
  bool dragging = false;
  bool resizing = false;

  @override
  Widget build(BuildContext context) {
    log.v('DraggableItemWidget(${widget.id}).build');

    final item = ref.watch(itemProvider(widget.id));
    final itemListNotifier = ref.read(itemListProvider.notifier);

    return item == null
        ? Container()
        : Positioned(
            left: item.point.x.toDouble(),
            top: item.point.y.toDouble(),
            child: GestureDetector(
              onTapDown: (details) {
                if (_calculateMode(item.size, details.localPosition) == InteractionMode.moving) {
                  dragging = true;
                } else {
                  resizing = true;
                }
              },
              onPanEnd: (details) {
                dragging = false;
                resizing = false;
                itemListNotifier.clearHighlight();
              },
              onPanStart: (details) {
                point = details.localPosition;
              },
              onPanUpdate: (details) {
                if (dragging) {
                  if (item.selected) {
                    itemListNotifier.moveSelected(item.id, details.delta);
                  }
                  itemListNotifier.moveItem(item.id, details.delta);
                } else if (resizing) {
                  itemListNotifier.resizeItem(item.id, details.delta);
                }
              },
              onDoubleTap: () {
                itemListNotifier.bringToFront(item);
              },
              onLongPress: () {
                itemListNotifier.updateItem(item.copyWith(selected: !item.selected));
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
                child: ScrollPaneItemWidget.debug && item.size.width > 100 && item.size.height > 40
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

  InteractionMode _calculateMode(Size size, Offset offset) {
    return ((size.width - offset.dx) < 20) && ((size.height - offset.dy) < 20)
        ? InteractionMode.resizing
        : InteractionMode.moving;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
