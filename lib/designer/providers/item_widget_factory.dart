import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/components/icon_component.dart';
import 'package:wt_console_designer/designer/components/info_component.dart';
import 'package:wt_console_designer/designer/components/select_component.dart';
import 'package:wt_console_designer/designer/components/slider_component.dart';
import 'package:wt_console_designer/designer/components/switch_component.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/slider_item.dart';

final itemWidgetFactoryProvider = Provider(
  name: 'ItemWidgetFactory',
  (ref) => ItemWidgetFactory(),
);

class ItemWidgetFactory {
  static final builders = <ItemType, Widget Function(Item)>{
    ItemType.icon: (item) => const IconComponent(),
    ItemType.toggle: (item) => const SwitchComponent(),
    ItemType.slider: (item) => SliderComponent((item as SliderItem).state),
    ItemType.info: (item) => const InfoComponent(),
    ItemType.select: (item) => const SelectComponent(),
  };

  Widget createWidget(Item item) {
    if (!builders.containsKey(item.type)) {
      throw Exception('There is no builder for creating Component(${item.type.name})');
    }
    return builders[item.type]!(item);
  }
}
