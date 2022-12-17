import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderToolBar(),
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
          // const ItemConfiguration(),
        ],
      ),
    );
  }
}

class HeaderToolBar extends ConsumerWidget {
  const HeaderToolBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.home),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  notifier.clear();
                  Future.delayed(const Duration(milliseconds: 1), () {
                    notifier.load();
                  });
                },
                icon: const Icon(Icons.download),
              ),
              IconButton(
                onPressed: () {
                  notifier.save();
                },
                icon: const Icon(
                  Icons.upload,
                ),
              ),
              IconButton(
                onPressed: () {
                  notifier.clear();
                },
                icon: const Icon(Icons.clear),
              ),
              IconButton(
                onPressed: () {
                  notifier.clear(true);
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  print(notifier.getDefinition());
                },
                icon: const Icon(Icons.share),
              ),
              IconButton(
                onPressed: () {
                  notifier.create();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          )
        ],
      ),
    );
  }
}
