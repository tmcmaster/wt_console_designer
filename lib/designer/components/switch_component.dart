import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/switch_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_logging/wt_logging.dart';

class SwitchComponent extends ConsumerWidget {
  static final log = logger(SwitchComponent, level: Level.warning);
  final SwitchItem item;

  const SwitchComponent(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    return Switch(
      value: item.state.enabled,
      onChanged: (value) {
        ref.read(itemListProvider.notifier).updateItem(
              item.copyWith(
                state: item.state.copyWith(
                  enabled: value,
                ),
              ),
              save: true,
            );
      },
    );
  }
}
