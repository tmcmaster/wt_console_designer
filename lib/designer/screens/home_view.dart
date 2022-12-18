import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderToolBar(),
          Expanded(
            child: Row(
              children: [
                const ComponentPalette(),
                Expanded(
                  child: ScrollPane(
                    child: DesignerStack(),
                  ),
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

    final iconColor = Colors.grey.shade600;

    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                icon: Icon(Icons.home, color: iconColor),
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
                icon: Icon(Icons.undo_sharp, color: iconColor),
              ),
              IconButton(
                onPressed: () {
                  notifier.save();
                },
                icon: Icon(
                  Icons.save,
                  color: iconColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  notifier.clear(true);
                },
                icon: Icon(Icons.delete, color: iconColor),
              ),
              IconButton(
                onPressed: () {
                  notifier.clear();
                },
                icon: Icon(FontAwesomeIcons.trash, color: iconColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
