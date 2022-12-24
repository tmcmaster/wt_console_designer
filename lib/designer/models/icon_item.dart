import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'icon_item.freezed.dart';
part 'icon_item.g.dart';

@freezed
class IconItemState with _$IconItemState {
  IconItemState._();
  factory IconItemState({
    required String icon,
  }) = _IconItemState;
  factory IconItemState.fromJson(Map<String, Object?> json) => _$IconItemStateFromJson(json);
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
