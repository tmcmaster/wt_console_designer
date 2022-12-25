import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/switch_item.dart';
import 'package:wt_logging/wt_logging.dart';

class SwitchComponent extends StatelessWidget {
  static final log = logger(SwitchComponent, level: Level.warning);
  final SwitchItem item;

  const SwitchComponent(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Switch(
      value: item.state.enabled,
      onChanged: (value) {},
    );
  }
}
