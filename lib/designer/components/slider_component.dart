import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/slider_item.dart';
import 'package:wt_logging/wt_logging.dart';

class SliderComponent extends StatelessWidget {
  static final log = logger(SliderComponent, level: Level.warning);
  final SliderItem item;
  const SliderComponent(
    this.item, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Slider(
      min: item.state.min,
      max: item.state.max,
      value: item.state.value,
      onChanged: (double value) {},
    );
  }
}
