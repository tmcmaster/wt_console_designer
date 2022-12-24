import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'switch_item.freezed.dart';
part 'switch_item.g.dart';

@freezed
class SwitchItemState with _$SwitchItemState {
  SwitchItemState._();
  factory SwitchItemState({
    @JsonKey(name: 'enabled') required bool enabled,
  }) = _SwitchItemStateState;
  factory SwitchItemState.fromJson(Map<String, Object?> json) => _$SwitchItemStateFromJson(json);
}

@freezed
class SwitchItem with _$SwitchItem, Item<$SwitchItemCopyWith<SwitchItem>> {
  SwitchItem._();

  factory SwitchItem({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'type') @Default(ItemType.toggle) ItemType type,
    @JsonKey(name: 'layout') required ItemLayout layout,
    @JsonKey(name: 'state') required SwitchItemState state,
  }) = _SwitchItem;

  factory SwitchItem.fromJson(Map<String, Object?> json) => _$SwitchItemFromJson(json);
}
