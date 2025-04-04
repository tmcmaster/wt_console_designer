import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/icon_item.dart';
import 'package:wt_logging/wt_logging.dart';

class IconComponent extends StatelessWidget {
  static final log = logger(IconComponent, level: Level.warning);
  final IconItem item;
  const IconComponent(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Icon(item.state.icon);
  }
}
