import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';

class ItemConfiguration extends ConsumerWidget {
  const ItemConfiguration({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItems);
    final notifier = ref.read(itemListProvider.notifier);

    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      color: Colors.grey.shade100,
      height: 200,
      child: selected.length == 1
          ? Wrap(
              children: [Colors.red, Colors.yellow, Colors.orange]
                  .map(
                    (color) => SizedBox(
                      width: 50,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
                          child: Container(),
                          onPressed: () {
                            // print(color);
                            notifier.updateItem(selected.first.copyWith(color: color));
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(),
            )
          : Container(),
    );
  }
}
