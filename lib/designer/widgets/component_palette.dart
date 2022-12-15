import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';

class ComponentPalette extends ConsumerWidget {
  const ComponentPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(itemListProvider.notifier);
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Size(50.0, 50.0),
          const Size(100.0, 50.0),
          const Size(50.0, 75.0),
          const Size(300.0, 75.0),
        ]
            .map((size) => SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                      child: Container(),
                      onPressed: () {
                        notifier.create(
                          point: const Point(50.0, 50.0),
                          size: size,
                        );
                      },
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
