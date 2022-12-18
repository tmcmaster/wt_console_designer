import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';

class PaletteItem {
  final IconData icon;
  final ItemType type;
  final Size size;
  final String label;
  final Color color;

  const PaletteItem({
    required this.icon,
    this.size = const Size(250, 59),
    required this.type,
    required this.label,
    this.color = Colors.white,
  });
}
