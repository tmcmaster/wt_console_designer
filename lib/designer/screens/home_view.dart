import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';
import 'package:wt_console_designer/designer/widgets/item_configuration.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arrange Items'),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    notifier.clear();
                    Future.delayed(const Duration(milliseconds: 1), () {
                      notifier.load();
                    });
                  },
                  child: const Icon(Icons.download),
                ),
                FloatingActionButton(
                  onPressed: () {
                    notifier.save();
                  },
                  child: const Icon(
                    Icons.upload,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    notifier.clear();
                  },
                  child: const Icon(Icons.clear),
                ),
                FloatingActionButton(
                  onPressed: () {
                    notifier.clear(true);
                  },
                  child: const Icon(Icons.delete),
                ),
                FloatingActionButton(
                  onPressed: () {
                    print(notifier.getDefinition());
                  },
                  child: const Icon(Icons.share),
                ),
                FloatingActionButton(
                  onPressed: () {
                    notifier.create();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: const [
                ComponentPalette(),
                Expanded(
                  child: DesignerStack(),
                ),
              ],
            ),
          ),
          const ItemConfiguration(),
        ],
      ),
    );
  }
}
