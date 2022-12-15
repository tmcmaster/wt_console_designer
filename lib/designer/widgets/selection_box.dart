import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/selection_provider.dart';

class SelectionBox extends ConsumerWidget {
  static const debug = false;

  const SelectionBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final region = ref.watch(selectionProvider);

    return region == null
        ? Container()
        : Positioned(
            left: region.left.toDouble(),
            top: region.top.toDouble(),
            child: Container(
              width: region.width.toDouble(),
              height: region.height.toDouble(),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.orange,
                ),
              ),
              child: debug && region.width > 100 && region.height > 40
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Pos(${region.left.toInt()},${region.top.toInt()})'),
                        Text('Size(${region.width.toInt()}, ${region.height.toInt()})'),
                      ],
                    )
                  : Container(),
            ),
          );
  }
}
