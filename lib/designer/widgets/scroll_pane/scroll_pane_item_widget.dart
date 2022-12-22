part of 'scroll_pane.dart';

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
                      ),
                  ],
                ),
                width: item.size.width,
                height: item.size.height,
                child: IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildItemWidget(item),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildItemWidget(Item item) {
    return ref.read(itemWidgetFactoryProvider).createWidget(item);
  }

  InteractionMode _calculateMode(Size size, Offset offset) {
    return ((size.width - offset.dx) < 20) && ((size.height - offset.dy) < 20)
        ? InteractionMode.resizing
        : InteractionMode.moving;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
