import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';

class MovableStackItem extends StatefulWidget {
  final BoxConstraints constraints;
  final Item item;

  const MovableStackItem({
    super.key,
    required this.item,
    required this.constraints,
  });

  @override
  State<MovableStackItem> createState() => _MovableStackItemState();
}

class _MovableStackItemState extends State<MovableStackItem> {
  static const debug = true;

  double xPosition = 0;
  double yPosition = 0;
  double width = 0;
  double height = 0;

  bool moving = false;
  bool resizing = false;

  @override
  void initState() {
    xPosition = widget.item.point.x.toDouble();
    yPosition = widget.item.point.y.toDouble();
    width = widget.item.size.width.toDouble();
    height = widget.item.size.height.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = widget.constraints.maxWidth;
    final containerHeight = widget.constraints.maxHeight;
    return Positioned(
      key: ValueKey(widget.item.id),
      top: yPosition,
      left: xPosition,
      child: Consumer(builder: (_, ref, __) {
        final notifier = ref.read(itemListProvider.notifier);
        return GestureDetector(
          onPanUpdate: (tapInfo) {
            if (moving) {
              final newX = xPosition + tapInfo.delta.dx;
              final newY = yPosition + tapInfo.delta.dy;
              if (newX > 0 &&
                  (newX + width) < containerWidth &&
                  newY > 0 &&
                  (newY + height) < containerHeight) {
                setState(() {
                  xPosition += tapInfo.delta.dx;
                  yPosition += tapInfo.delta.dy;
                });
              }
            } else if (resizing) {
              final newWidth = width + tapInfo.delta.dx;
              final newHeight = height + tapInfo.delta.dy;
              if ((xPosition + newWidth) < containerWidth &&
                  (yPosition + newHeight) < containerHeight) {
                setState(() {
                  width += tapInfo.delta.dx;
                  height += tapInfo.delta.dy;
                });
              }
            }
          },
          onPanEnd: (details) {
            moving = false;
            resizing = false;
            notifier.updateItem(widget.item.copyWith(
              point: Point(xPosition, yPosition),
              size: Size(width, height),
            ));
          },
          onPanStart: (details) {
            setState(() {
              if (inCorner(details.localPosition) && widget.item.resize) {
                resizing = true;
              } else {
                moving = true;
              }
            });
          },
          onTap: () {
            notifier.toggleSelection(widget.item, clearSelection: true);
          },
          onLongPress: () {
            notifier.toggleSelection(widget.item, clearSelection: false);
          },
          child: Container(
            decoration: BoxDecoration(
              border: widget.item.selected
                  ? Border.all(color: Colors.black, width: 2)
                  : Border.all(color: Colors.grey, width: 1),
              color: widget.item.color,
              boxShadow: [
                if (moving)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
              ],
            ),
            width: width,
            height: height,
            child: debug && width > 100 && height > 40
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Pos(${xPosition.toInt()},${xPosition.toInt()})'),
                      Text('Size(${width.toInt()}, ${height.toInt()})'),
                    ],
                  )
                : Container(),
          ),
        );
      }),
    );
  }

  bool inCorner(Offset point) {
    final xDiff = (width - point.dx).abs();
    final yDiff = (height - point.dy).abs();
    return xDiff < 20 && yDiff < 20;
  }
}
