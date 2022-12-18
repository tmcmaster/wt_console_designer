import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';
import 'package:wt_console_designer/designer/models/palette_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/template_item.dart';

class ComponentPalette extends ConsumerWidget {
  const ComponentPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItems);
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: 75,
        height: constraints.maxHeight,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: selected.isEmpty ? 0 : -75,
              child: Container(
                width: 150,
                height: constraints.maxHeight,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ItemCreationPalette(),
                    ItemPropertiesPalette(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selected.isEmpty ? const ItemCreationPalette() : const ItemPropertiesPalette(),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(selected.isEmpty ? 1.0 : -1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
    // return selected.isEmpty ? const ItemCreationPalette() : const ItemPropertiesPalette();
  }
}

class ComponentPaletteHold extends ConsumerWidget {
  const ComponentPaletteHold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItems);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: selected.isEmpty ? const ItemCreationPalette() : const ItemPropertiesPalette(),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(selected.isEmpty ? 1.0 : -1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
    // return selected.isEmpty ? const ItemCreationPalette() : const ItemPropertiesPalette();
  }
}

class ItemCreationPalette extends StatelessWidget {
  const ItemCreationPalette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          right: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...[
            const PaletteItem(
              label: 'Note',
              type: ItemType.note,
              icon: Icons.note,
            ),
            const PaletteItem(
              label: 'Link',
              type: ItemType.link,
              icon: Icons.link,
            ),
            const PaletteItem(
              label: 'To-do',
              type: ItemType.todo,
              icon: FontAwesomeIcons.listCheck,
            ),
            // const PaletteItem(
            //   label: 'Line',
            //   type: ItemType.line,
            //   icon: FontAwesomeIcons.line,
            // ),
          ]
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TemplateItem(
                    label: item.label,
                    icon: item.icon,
                    item: Item(
                      id: '',
                      type: item.type,
                      highlighted: false,
                      selected: false,
                      point: const Point(100, 100),
                      size: item.size,
                      color: item.color,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class ItemPropertiesPalette extends ConsumerWidget {
  const ItemPropertiesPalette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListNotifier = ref.read(itemListProvider.notifier);
    final items = ref.watch(selectedItems);
    // final item = items[0];
    return Container(
      width: 75,
      padding: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          right: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            child: IconButton(
              onPressed: () {
                itemListNotifier.clearSelection();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade800,
                size: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: items.isNotEmpty ? items[0].color : Colors.white,
                      onColorChanged: (color) {
                        itemListNotifier
                            .updateItems(items.map((item) => item.copyWith(color: color)).toList());
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.color_lens,
              color: Colors.grey.shade800,
            ),
          ),
          if (items.length > 1) const AlignmentControls()
        ],
      ),
    );
  }
}

class AlignmentControls extends ConsumerWidget {
  const AlignmentControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(selectedItems);
    final itemListNotifier = ref.read(itemListProvider.notifier);

    final Map<IconData, void Function(List<Item>)> actions = {
      Icons.align_horizontal_center: itemListNotifier.horizontalCenterAlign,
      Icons.align_horizontal_left: itemListNotifier.leftAlign,
      Icons.align_horizontal_right: itemListNotifier.rightAlign,
      Icons.align_vertical_center: itemListNotifier.verticalCenterAlign,
      Icons.align_vertical_top: itemListNotifier.topAlign,
      Icons.align_vertical_bottom: itemListNotifier.bottomAlign,
    };

    return Column(
      children: actions.entries
          .map(
            (entry) => IconButton(
              onPressed: () {
                entry.value(items);
              },
              icon: Icon(
                entry.key,
                color: Colors.grey.shade800,
              ),
            ),
          )
          .toList(),
    );
  }
}
