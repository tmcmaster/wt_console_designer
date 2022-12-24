import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'select_item.freezed.dart';
part 'select_item.g.dart';

@freezed
class SelectItemState with _$SelectItemState {
  SelectItemState._();
  factory SelectItemState({
    @JsonKey(name: 'options') required List<String> options,
    @JsonKey(name: 'value') required String value,
  }) = _SelectItemStateState;
  factory SelectItemState.fromJson(Map<String, Object?> json) => _$SelectItemStateFromJson(json);
}

@freezed
class SelectItem with _$SelectItem, Item<$SelectItemCopyWith<SelectItem>> {
  SelectItem._();

  factory SelectItem({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'type') @Default(ItemType.select) ItemType type,
    @JsonKey(name: 'layout') required ItemLayout layout,
    @JsonKey(name: 'state') required SelectItemState state,
  }) = _SelectItem;

  factory SelectItem.fromJson(Map<String, Object?> json) => _$SelectItemFromJson(json);
}
