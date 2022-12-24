import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class SwitchComponent extends StatelessWidget {
  static final log = logger(SwitchComponent, level: Level.verbose);
  const SwitchComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Switch(value: true, onChanged: (value) {});
  }
}
