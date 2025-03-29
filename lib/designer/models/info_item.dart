import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'info_item.freezed.dart';
part 'info_item.g.dart';

@freezed
class InfoItemState with _$InfoItemState {
  InfoItemState._();
  factory InfoItemState({
    @JsonKey(name: 'value') required String value,
  }) = _InfoItemStateState;
  factory InfoItemState.fromJson(Map<String, Object?> json) =>
      _$InfoItemStateFromJson(json);
}

@freezed
class InfoItem extends Item<$InfoItemCopyWith<InfoItem>> with _$InfoItem {
  InfoItem._();

  factory InfoItem({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'type') @Default(ItemType.info) ItemType type,
    @JsonKey(name: 'layout') required ItemLayout layout,
    @JsonKey(name: 'state') required InfoItemState state,
  }) = _InfoItem;

  factory InfoItem.fromJson(Map<String, Object?> json) =>
      _$InfoItemFromJson(json);
}
