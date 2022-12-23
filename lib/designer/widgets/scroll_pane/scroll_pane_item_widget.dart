part of 'scroll_pane.dart';

class ScrollPaneItemWidget extends ConsumerWidget {
  static final log = logger(ScrollPaneItemWidget, level: Level.verbose);

  static const debug = false;

  final String id;
  final Widget child;

  const ScrollPaneItemWidget({
    super.key,
    required this.id,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('DraggableItemWidget($id).build');

    final item = ref.watch(itemProvider(id));
    final itemListNotifier = ref.read(itemListProvider.notifier);

    return item == null
        ? Container()
        : Positioned(
            left: item.point.x.toDouble(),
            top: item.point.y.toDouble(),
            width: item.size.width,
            height: item.size.height,
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
              child: DragAndMoveListener(
                onBringToFront: () {
                  itemListNotifier.bringToFront(item);
                },
                onSelect: () {
                  itemListNotifier.updateItem(item.copyWith(selected: !item.selected));
                },
                onResize: (delta) {
                  itemListNotifier.resizeItem(item.id, delta);
                },
                onMove: (delta) {
                  if (item.selected) {
                    itemListNotifier.moveSelected(item.id, delta);
                  }
                  itemListNotifier.moveItem(item.id, delta);
                },
                onFinish: () {
                  itemListNotifier.clearHighlight();
                },
                resizeHandleRegion: Rectangle(item.size.width - 20, item.size.height - 20, 20, 20),
                child: Container(
                  // width: double.infinity,
                  // height: double.infinity,
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FittedBox(
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class DragAndMoveListener extends StatefulWidget {
  final Rectangle<double> resizeHandleRegion;
  final void Function(Offset delta) onResize;
  final void Function(Offset delta) onMove;
  final void Function() onFinish;
  final void Function() onBringToFront;
  final void Function() onSelect;
  final Widget child;

  const DragAndMoveListener({
    super.key,
    required this.resizeHandleRegion,
    required this.onResize,
    required this.onMove,
    required this.onFinish,
    required this.onBringToFront,
    required this.onSelect,
    required this.child,
  });

  @override
  State<DragAndMoveListener> createState() => _DragAndMoveListenerState();
}

class _DragAndMoveListenerState extends State<DragAndMoveListener> {
  Offset? point;
  bool dragging = false;
  bool resizing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        if (_calculateMode(widget.resizeHandleRegion, details.localPosition) ==
            InteractionMode.moving) {
          dragging = true;
        } else {
          resizing = true;
        }
      },
      onPanEnd: (details) {
        dragging = false;
        resizing = false;
        widget.onFinish();
      },
      onPanStart: (details) {
        point = details.localPosition;
      },
      onPanUpdate: (details) {
        if (dragging) {
          widget.onMove(details.delta);
        } else if (resizing) {
          widget.onResize(details.delta);
        }
      },
      onDoubleTap: () {
        widget.onBringToFront();
      },
      onLongPress: () {
        widget.onSelect();
      },
      child: widget.child,
    );
  }

  InteractionMode _calculateMode(Rectangle<double> region, Offset offset) {
    return region.containsPoint(Point(offset.dx, offset.dy))
        ? InteractionMode.resizing
        : InteractionMode.moving;
  }
}
