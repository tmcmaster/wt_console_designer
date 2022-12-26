import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/select_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_logging/wt_logging.dart';

class SelectComponent extends ConsumerWidget {
  static final log = logger(SelectComponent, level: Level.warning);
  final SelectItem item;
  const SelectComponent(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    return DropdownButton(
      value: item.state.value,
      items: item.state.options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          ref.read(itemListProvider.notifier).updateItem(
                item.copyWith(
                  state: item.state.copyWith(
                    value: value,
                  ),
                ),
                save: true,
              );
        }
      },
    );
  }
}
