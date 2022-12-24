import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class InfoComponent extends StatelessWidget {
  static final log = logger(InfoComponent, level: Level.verbose);
  const InfoComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return const Text('Placeholder Text');
  }
}
