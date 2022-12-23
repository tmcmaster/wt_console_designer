import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';
import 'package:wt_logging/wt_logging.dart';

final itemWidgetFactoryProvider = Provider(
  name: 'ItemWidgetFactory',
  (ref) => ItemWidgetFactory(),
);

class ItemWidgetFactory {
  static final builders = <ItemType, Widget Function(Item)>{
    ItemType.icon: (item) => const IconComponent(),
    ItemType.toggle: (item) => const SwitchComponent(),
    ItemType.slider: (item) => const SliderComponent(),
    ItemType.info: (item) => const InfoComponent(),
    ItemType.select: (item) => const SelectComponent(),
  };

  Widget createWidget(Item item) {
    final builder = builders[item.type] ?? (item) => const Icon(FontAwesomeIcons.question);
    return builder(item);
  }
}

class SelectComponent extends StatelessWidget {
  static final log = logger(SelectComponent, level: Level.verbose);
  const SelectComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return DropdownButton(
      value: 'one',
      items: const [
        DropdownMenuItem(value: 'one', child: Text('Option One')),
        DropdownMenuItem(value: 'two', child: Text('Option Two')),
        DropdownMenuItem(value: 'three', child: Text('Option Three')),
      ],
      onChanged: (value) {},
    );
  }
}

class InfoComponent extends StatelessWidget {
  static final log = logger(InfoComponent, level: Level.verbose);
  const InfoComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return const Text('Placeholder Text');
  }
}

class SliderComponent extends StatelessWidget {
  static final log = logger(SliderComponent, level: Level.verbose);
  const SliderComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Slider(value: 0.5, onChanged: (double value) {});
  }
}

class SwitchComponent extends StatelessWidget {
  static final log = logger(SwitchComponent, level: Level.verbose);
  const SwitchComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Switch(value: true, onChanged: (value) {});
  }
}

class IconComponent extends StatelessWidget {
  static final log = logger(IconComponent, level: Level.verbose);
  const IconComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return const Icon(Icons.person);
  }
}
