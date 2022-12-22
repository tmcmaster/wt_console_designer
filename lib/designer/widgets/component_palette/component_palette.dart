import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';
import 'package:wt_console_designer/designer/models/palette_item.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/widgets/template_item.dart';

part 'alignment_controls.dart';
part 'item_creation_palette.dart';
part 'item_properties_palette.dart';

class ComponentPalette extends ConsumerWidget {
  const ComponentPalette({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedItems);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: 75,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                left: selected.isEmpty ? 0 : -75,
                child: Container(
                  width: 150,
                  height: constraints.maxHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ItemCreationPalette(),
                      ItemPropertiesPalette(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
