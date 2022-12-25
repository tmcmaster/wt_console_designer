import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'icon_item.freezed.dart';
part 'icon_item.g.dart';

@freezed
class IconItemState with _$IconItemState {
  IconItemState._();
  factory IconItemState({
    @JsonKey(name: 'icon', fromJson: IconItemState.iconFromJson, toJson: IconItemState.iconToJson)
    @Default(Icons.person)
        IconData icon,
  }) = _IconItemState;

  factory IconItemState.fromJson(Map<String, Object?> json) => _$IconItemStateFromJson(json);

  static IconData iconFromJson(Map<String, dynamic> map) {
    return IconData(map['codePoint'], fontFamily: map['fontFamily']);
  }

  static Map<String, dynamic> iconToJson(IconData icon) {
    return {
      'codePoint': icon.codePoint,
      'fontFamily': icon.fontFamily,
    };
  }
}

@freezed
class IconItem with _$IconItem, Item<$IconItemCopyWith<IconItem>> {
  IconItem._();
  factory IconItem({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'type') @Default(ItemType.icon) ItemType type,
    @JsonKey(name: 'layout') required ItemLayout layout,
    @JsonKey(name: 'state') required IconItemState state,
  }) = _IconItem;

  factory IconItem.fromJson(Map<String, Object?> json) => _$IconItemFromJson(json);
}
