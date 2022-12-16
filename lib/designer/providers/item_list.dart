import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/providers/item_list_json.dart';

final itemCountProvider = Provider((ref) => ref.watch(itemListProvider).length);

final selectedItems = Provider<List<Item>>(
    (ref) => ref.watch(itemListProvider).where((item) => item.selected).toList());

final itemProvider = Provider.autoDispose.family<Item?, String>(
  (ref, id) {
    final options = ref.watch(itemListProvider).where((item) => item.id == id);

    return options.isEmpty
        ? null
        : ref.watch(itemListProvider).where((item) => item.id == id).first;
  },
);

final itemListProvider = StateNotifierProvider<ItemListNotifier, List<Item>>(
  (ref) => ItemListNotifier(ref),
);

class ItemListNotifier extends StateNotifier<List<Item>> {
  static const uuid = Uuid();

  final Ref ref;

  ItemListNotifier(this.ref)
      : super([
          Item(
            id: "001",
            point: const Point(10, 10),
            size: const Size(100, 100),
            color: Colors.yellow,
            selected: false,
            highlighted: false,
          ),
          Item(
            id: "002",
            point: const Point(20, 20),
            size: const Size(100, 100),
            color: Colors.yellow,
            selected: false,
            highlighted: false,
          ),
        ]);

  void create({
    Point? point,
    Size? size,
    Color? color,
    bool? selected,
    bool? highlighted,
    double? aspect,
    bool? resize,
  }) {
    final id = uuid.v1();
    state = [
      ...state,
      Item(
        id: id,
        point: point ?? const Point(10, 10),
        size: size ?? const Size(100, 100),
        color: color ?? Colors.yellow,
        selected: selected ?? false,
        highlighted: highlighted ?? false,
        aspect: aspect,
        resize: resize ?? true,
      )
    ];
  }

  void add(Item newItem) {
    state = [
      ...state,
      newItem,
    ];
  }

  void updateItem(Item newItem) {
    state = [...state.where((item) => item.id != newItem.id).toList(), newItem];
  }

  void clearSelection() {
    state = state.map((item) => item.selected ? item.copyWith(selected: false) : item).toList();
  }

  void toggleSelection(Item itemToToggle, {bool clearSelection = false}) {
    state = [
      ...state
          .where((item) => item.id != itemToToggle.id)
          .map((item) => clearSelection ? item.copyWith(selected: false) : item)
          .toList(),
      itemToToggle.copyWith(selected: !itemToToggle.selected),
    ];
  }

  void load() {
    final itemListJson = ref.read(itemListJsonProvider);
    state = itemListJson.map((map) => Item.fromJson(map)).toList();
  }

  void save() {
    final json = state.map((item) => item.toJson()).toList();
    ref.read(itemListJsonProvider.notifier).update(json);
  }

  void clear([bool onlySelected = false]) {
    if (onlySelected) {
      state = state.where((item) => !item.selected).toList();
    } else {
      state = [];
    }
  }

  String getDefinition() {
    return json.encode([...state].map((item) => item.toJson()).toList());
  }

  // TODO: need to investigate why intersection seems to be selecting extra items.
  void selectInRegion(Rectangle region) {
    state = state.map((item) {
      final isWithin = region.intersection(item.bounds) != null;
      return isWithin ? item.copyWith(selected: true) : item.copyWith(selected: false);
    }).toList();
  }

  bool isWithin(Item item, Rectangle region) {
    final isBetween = (item.point.x > region.left &&
        item.point.x < region.right &&
        item.point.y > region.top &&
        item.point.y < region.bottom);

    return isBetween;
  }
}
