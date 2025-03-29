import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wt_console_designer/designer/models/item.dart';
import 'package:wt_console_designer/designer/models/item_layout.dart';

part 'slider_item.freezed.dart';
part 'slider_item.g.dart';

@freezed
class SliderItemState with _$SliderItemState {
  SliderItemState._();
  factory SliderItemState({
    @JsonKey(name: 'min') required double min,
    @JsonKey(name: 'max') required double max,
    @JsonKey(name: 'value') required double value,
  }) = _SliderItemStateState;
  factory SliderItemState.fromJson(Map<String, Object?> json) =>
      _$SliderItemStateFromJson(json);
}

@freezed
class SliderItem extends Item<$SliderItemCopyWith<SliderItem>>
    with _$SliderItem {
  SliderItem._();

  factory SliderItem({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'type') @Default(ItemType.slider) ItemType type,
    @JsonKey(name: 'layout') required ItemLayout layout,
    @JsonKey(name: 'state') required SliderItemState state,
  }) = _SliderItem;

  factory SliderItem.fromJson(Map<String, Object?> json) =>
      _$SliderItemFromJson(json);
}
