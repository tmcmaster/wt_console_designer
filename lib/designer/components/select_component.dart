import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class SelectComponent extends StatelessWidget {
  static final log = logger(SelectComponent, level: Level.verbose);
  const SelectComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return DropdownButton(
      value: 'one',
      items: const [
        DropdownMenuItem(value: 'one', child: Text('Option One')),
        DropdownMenuItem(value: 'two', child: Text('Option Two')),
        DropdownMenuItem(value: 'three', child: Text('Option Three')),
      ],
      onChanged: (value) {},
    );
  }
}
