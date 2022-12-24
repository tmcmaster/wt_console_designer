import 'dart:convert';

import 'package:wt_console_designer/designer/models/icon_item.dart';
import 'package:wt_console_designer/designer/models/info_item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';
import 'package:wt_console_designer/designer/models/select_item.dart';
import 'package:wt_console_designer/designer/models/slider_item.dart';
import 'package:wt_console_designer/designer/models/switch_item.dart';

enum ItemType { icon, toggle, slider, info, select }

abstract class Item<T> {
  String get id;
  ItemType get type;
  ItemLayout get layout;

  static Item fromJson(Map<String, dynamic> map) {
    if (map['type'] == "toggle") {
      return SwitchItem.fromJson(map);
    } else if (map['type'] == "icon") {
      return IconItem.fromJson(map);
    } else if (map['type'] == "slider") {
      return SliderItem.fromJson(map);
    } else if (map['type'] == "info") {
      return InfoItem.fromJson(map);
    } else if (map['type'] == "select") {
      return SelectItem.fromJson(map);
    } else {
      throw Exception('Invalid Type: ${map['type']}');
    }
  }

  static List<Item> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((map) => Item.fromJson(map)).toList();
  }

  static List<Item> fromJsonListString(String jsonListString) {
    final List<Map<String, dynamic>> jsonList = json.decode(jsonListString);
    return jsonList.map((map) => Item.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson();

  T get copyWith;
}
