import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/move_resize_provider.dart';

class DraggableItemWidget extends ConsumerWidget {
  static const debug = true;

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
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
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
                    : Container(),
              ),
            ),
          );
  }
}

// class DraggableStackWidget extends ConsumerStatefulWidget {
//   final BoxConstraints constraints;
//   final String id;
//
//   const DraggableStackWidget({
//     super.key,
//     required this.constraints,
//     required this.id,
//   });
//
//   @override
//   ConsumerState<DraggableStackWidget> createState() => _DraggableStackWidgetState();
// }
//
// class _DraggableStackWidgetState extends ConsumerState<DraggableStackWidget> {
//   static const debug = true;
//
//   double xPosition = 0;
//   double yPosition = 0;
//
//   bool moving = false;
//   bool resizing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final item = ref.watch(itemProvider(widget.id));
//
//     final containerWidth = widget.constraints.maxWidth;
//     final containerHeight = widget.constraints.maxHeight;
//
//     return Positioned(
//       key: ValueKey(item.id),
//       top: yPosition,
//       left: xPosition,
//       child: Consumer(builder: (_, ref, __) {
//         final notifier = ref.read(itemListProvider.notifier);
//         return GestureDetector(
//           onPanUpdate: (tapInfo) {
//             if (moving) {
//               final newX = xPosition + tapInfo.delta.dx;
//               final newY = yPosition + tapInfo.delta.dy;
//               if (newX > 0 &&
//                   (newX + item.size.width) < containerWidth &&
//                   newY > 0 &&
//                   (newY + item.size.height) < containerHeight) {
//                 setState(() {
//                   xPosition += tapInfo.delta.dx;
//                   yPosition += tapInfo.delta.dy;
//                 });
//               }
//             } else if (resizing) {
//               final newWidth = item.size.width + tapInfo.delta.dx;
//               final newHeight = item.size.height + tapInfo.delta.dy;
//               if ((xPosition + newWidth) < containerWidth &&
//                   (yPosition + newHeight) < containerHeight) {
//                 setState(() {
//                   width += tapInfo.delta.dx;
//                   height += tapInfo.delta.dy;
//                 });
//               }
//             }
//           },
//           onPanEnd: (details) {
//             moving = false;
//             resizing = false;
//             notifier.updateItem(widget.item.copyWith(
//               point: Point(xPosition, yPosition),
//               size: Size(width, height),
//             ));
//           },
//           onPanStart: (details) {
//             setState(() {
//               if (inCorner(details.localPosition) && widget.item.resize) {
//                 resizing = true;
//               } else {
//                 moving = true;
//               }
//             });
//           },
//           onTap: () {
//             notifier.toggleSelection(widget.item, clearSelection: true);
//           },
//           onLongPress: () {
//             notifier.toggleSelection(widget.item, clearSelection: false);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               border: widget.item.selected
//                   ? Border.all(color: Colors.black, width: 2)
//                   : Border.all(color: Colors.grey, width: 1),
//               color: widget.item.color,
//               boxShadow: [
//                 if (moving)
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: Offset(0, 3), // changes position of shadow
//                   ),
//               ],
//             ),
//             width: width,
//             height: height,
//             child: debug && width > 100 && height > 40
//                 ? Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text('Pos(${xPosition.toInt()},${xPosition.toInt()})'),
//                       Text('Size(${width.toInt()}, ${height.toInt()})'),
//                     ],
//                   )
//                 : Container(),
//           ),
//         );
//       }),
//     );
//   }
//
//   bool inCorner(Offset point) {
//     final xDiff = (width - point.dx).abs();
//     final yDiff = (height - point.dy).abs();
//     return xDiff < 20 && yDiff < 20;
//   }
// }
