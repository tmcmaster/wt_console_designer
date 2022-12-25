import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/info_item.dart';
import 'package:wt_logging/wt_logging.dart';

class InfoComponent extends StatelessWidget {
  static final log = logger(InfoComponent, level: Level.warning);

  final InfoItem item;
  const InfoComponent(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Text(item.state.value);
  }
}
