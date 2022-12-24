import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/slider_item.dart';
import 'package:wt_logging/wt_logging.dart';

class SliderComponent extends StatelessWidget {
  static final log = logger(SliderComponent, level: Level.verbose);
  final SliderItemState state;
  const SliderComponent(
    this.state, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log.v('Building Widget');
    return Slider(
      min: state.min,
      max: state.max,
      value: state.value,
      onChanged: (double value) {},
    );
  }
}
