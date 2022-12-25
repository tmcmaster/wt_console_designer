import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';
import 'package:wt_console_designer/designer/widgets/palette_icon.dart';

class TemplateItem extends ConsumerWidget {
  static const uuid = Uuid();

  final IconData icon;
  final String label;
  final Item item;
  const TemplateItem({
    Key? key,
    required this.item,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);

    return Draggable<Item>(
      onDragEnd: (DraggableDetails details) {
        final box = stackKey.currentContext?.findRenderObject() as RenderBox;
        final offset = box.localToGlobal(Offset.zero);

        notifier.add(item.copyWith(
          id: uuid.v1(),
          layout: item.layout.copyWith(
            point: Point(
              details.offset.dx - offset.dx,
              details.offset.dy - offset.dy,
            ),
          ),
        ));
      },
      feedback: Container(
        color: item.layout.color.withOpacity(0.5),
        width: item.layout.size.width,
        height: item.layout.size.height,
        child: Icon(icon),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: PaletteIcon(icon: icon, label: label),
      ),
      child: PaletteIcon(icon: icon, label: label),
    );
  }
}
