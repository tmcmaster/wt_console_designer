import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/models/item.dart';

class PaletteItem {
  final IconData icon;
  final String label;
  final Item item;
  const PaletteItem({
    required this.icon,
    required this.label,
    required this.item,
  });
}
