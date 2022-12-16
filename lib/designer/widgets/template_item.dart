import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';

class TemplateItem extends ConsumerWidget {
  final IconData icon;
  final Item item;

  const TemplateItem({
    Key? key,
    required this.item,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);

    return Draggable<Item>(
      onDragEnd: (DraggableDetails details) {
        final box = stackKey.currentContext?.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero);

        notifier.create(
          point: Point(details.offset.dx - offset.dx, details.offset.dy - offset.dy),
          size: item.size,
          color: item.color,
        );
      },
      feedback: Container(
        color: item.color.withOpacity(0.5),
        width: item.size.width,
        height: item.size.height,
      ),
      childWhenDragging: Icon(
        icon,
        color: Colors.grey,
      ),
      child: Icon(icon, color: Colors.orange),
    );
  }
}
