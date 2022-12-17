import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/palette_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/template_item.dart';

class ComponentPalette extends ConsumerWidget {
  const ComponentPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItems);
    return selected.isEmpty ? const ItemCreationPalette() : const ItemPropertiesPalette();
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
              icon: Icons.abc,
              size: Size(50.0, 50.0),
            ),
            const PaletteItem(
              icon: Icons.fire_truck,
              size: Size(100.0, 50.0),
            ),
            const PaletteItem(
              icon: Icons.apartment,
              size: Size(50.0, 75.0),
            ),
            const PaletteItem(
              icon: Icons.access_alarm,
              size: Size(300.0, 75.0),
            ),
          ]
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TemplateItem(
                      icon: item.icon,
                      item: Item(
                        id: '',
                        highlighted: false,
                        selected: false,
                        point: const Point(100, 100),
                        size: item.size,
                        color: Colors.purple,
                      )),
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
    final items = ref.read(selectedItems);
    final item = items[0];
    return Container(
      width: 75,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              itemListNotifier.clearSelection();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: item.color,
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
            icon: const Icon(Icons.color_lens),
          ),
        ],
      ),
    );
  }
}
