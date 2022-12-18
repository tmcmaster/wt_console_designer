import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_type.dart';
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
            type: ItemType.note,
            point: const Point(100, 100),
            size: const Size(200, 75),
            color: Colors.white,
            selected: false,
            highlighted: false,
          ),
          Item(
            id: "002",
            type: ItemType.link,
            point: const Point(200, 200),
            size: const Size(200, 75),
            color: Colors.white,
            selected: false,
            highlighted: false,
          ),
        ]) {
    Future.delayed(const Duration(milliseconds: 100), () {
      save();
    });
  }

  void create({
    Point? point,
    Size? size,
    Color? color,
    bool? selected,
    bool? highlighted,
    double? aspect,
    bool? resize,
    ItemType? type,
  }) {
    final id = uuid.v1();
    add(Item(
      id: id,
      type: type ?? ItemType.note,
      point: point ?? const Point(10, 10),
      size: size ?? const Size(100, 100),
      color: color ?? Colors.white,
      selected: selected ?? false,
      highlighted: highlighted ?? false,
      aspect: aspect,
      resize: resize ?? true,
    ));
  }

  void add(Item newItem) {
    final offset = Offset(
      newItem.point.x < 0 ? newItem.point.x * -1 : 0,
      newItem.point.y < 0 ? newItem.point.y * -1 : 0,
    );

    if (offset.dx > 0 || offset.dy > 0) {
      // move all of the items to the right
      state = [
        ...state
            .map((item) => item.copyWith(
                    point: Point(
                  item.point.x + offset.dx,
                  item.point.y + offset.dy,
                )))
            .toList(),
        newItem.copyWith(
            point: Point(
          newItem.point.x + offset.dx,
          newItem.point.y + offset.dy,
        )),
      ];
    } else {
      state = [
        ...state,
        newItem,
      ];
    }
  }

  // TODO: need to review enabling items to be dragged off screen at the top and left.

  void updateItems(List<Item> items) {
    final itemMap = <String, Item>{for (var item in items) item.id: item};
    state = state.map((e) => itemMap[e.id] == null ? e : (itemMap[e.id] ?? e)).toList();
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

  void horizontalCenterAlign(List<Item> items) {
    return _align(items, (item) => Offset(item.point.x + (item.size.width / 2), 0));
  }

  void leftAlign(List<Item> items) {
    return _align(items, (item) => Offset(item.point.x.toDouble(), 0));
  }

  void rightAlign(List<Item> items) {
    return _align(items, (item) => Offset(item.point.x + item.size.width, 0));
  }

  void verticalCenterAlign(List<Item> items) {
    return _align(items, (item) => Offset(0, item.point.y + (item.size.height / 2)));
  }

  void topAlign(List<Item> items) {
    return _align(items, (item) => Offset(0, item.point.y.toDouble()));
  }

  void bottomAlign(List<Item> items) {
    return _align(items, (item) => Offset(0, item.point.y + item.size.height));
  }

  void _align(List<Item> items, Offset Function(Item) getValue) {
    if (items.length < 2) {
      print('More than one items need to be selected,');
      return;
    }
    final firstItem = items[0];
    final requiredCenter = getValue(firstItem);
    final updatedItems = items.sublist(1).map((item) {
      final center = getValue(item);
      final offset = requiredCenter - center;
      // print('RequiredCenter($requiredCenter), Center($center), Delta($offset)');
      return item.copyWith(
        point: Point(
          item.point.x + offset.dx,
          item.point.y + offset.dy,
        ),
      );
    }).toList();
    updateItems(updatedItems);
  }

  void bringToFront(Item selectedItem) {
    state = state.where((item) => item.id != selectedItem.id).toList();
    Future.delayed(const Duration(milliseconds: 50), () {
      add(selectedItem);
    });
  }
}
