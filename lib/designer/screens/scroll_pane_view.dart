import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/item_widget_factory.dart';
import 'package:wt_console_designer/designer/widgets/scroll_pane/scroll_pane.dart';
import 'package:wt_logging/wt_logging.dart';

class ScrollPaneView extends ConsumerWidget {
  static final log = logger(ScrollPaneView, level: Level.warning);

  const ScrollPaneView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('Building Widget');

    ref.watch(itemCountProvider);
    final items = ref.read(itemListProvider);
    final componentFactory = ref.read(itemWidgetFactoryProvider);

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: ScrollPane(
            children: items.map((item) {
              log.d('Building item ${item.id}');
              final component = componentFactory.createWidget(item);
              return ScrollPaneItemWidget(id: item.id, child: component);
            }).toList(),
          ),
        );
      }),
    );
  }
}

class TestWidget extends StatelessWidget {
  static const colors = [
    Colors.amber,
    Colors.indigo,
    Colors.teal,
    Colors.cyan,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];

  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Building TestWidget');
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      crossAxisCount: 3,
      children: colors
          .map((color) => Container(
                padding: const EdgeInsets.all(20),
                color: color.shade200,
                child: Center(
                  child: Text(color.toString()),
                ),
              ))
          .toList(),
    );
  }
}
