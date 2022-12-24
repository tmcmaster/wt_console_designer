import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class IconComponent extends StatelessWidget {
  static final log = logger(IconComponent, level: Level.verbose);
  const IconComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return const Icon(Icons.person);
  }
}
