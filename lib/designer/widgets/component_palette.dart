import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/palette_item.dart';
import 'package:wt_console_designer/designer/widgets/template_item.dart';

class ComponentPalette extends ConsumerWidget {
  const ComponentPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 75,
      color: Colors.grey.shade100,
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
