import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/models/slider_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_logging/wt_logging.dart';

class SliderComponent extends ConsumerWidget {
  static final log = logger(SliderComponent, level: Level.warning);
  final SliderItem item;
  const SliderComponent(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building Widget');
    return Slider(
      min: item.state.min,
      max: item.state.max,
      value: item.state.value,
      onChanged: (double value) {
        ref.read(itemListProvider.notifier).updateItem(
              item.copyWith(
                state: item.state.copyWith(
                  value: value,
                ),
              ),
              save: true,
            );
      },
    );
  }
}
