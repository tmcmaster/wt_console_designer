import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/select_item.dart';
import 'package:wt_logging/wt_logging.dart';

class SelectComponent extends StatelessWidget {
  static final log = logger(SelectComponent, level: Level.warning);
  final SelectItem item;
  const SelectComponent(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return DropdownButton(
      value: item.state.value,
      items: item.state.options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {},
    );
  }
}
