import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';

final itemWidgetFactoryProvider = Provider(
  name: 'ItemWidgetFactory',
  (ref) => ItemWidgetFactory(),
);

class ItemWidgetFactory {
  static final builders = <ItemType, Widget Function(Item)>{
    ItemType.icon: (item) => const Icon(Icons.person),
    ItemType.toggle: (item) => Switch(value: true, onChanged: (value) {}),
    ItemType.slider: (item) => Slider(value: 0.5, onChanged: (double value) {}),
    ItemType.info: (item) => const Text('Placeholder Text'),
    ItemType.select: (item) => DropdownButton(
          value: 'one',
          items: const [
            DropdownMenuItem(value: 'one', child: Text('Option One')),
            DropdownMenuItem(value: 'two', child: Text('Option Two')),
            DropdownMenuItem(value: 'three', child: Text('Option Three')),
          ],
          onChanged: (value) {},
        ),
  };

  Widget createWidget(Item item) {
    final builder = builders[item.type] ?? (item) => const Icon(FontAwesomeIcons.question);
    return builder(item);
  }
}
