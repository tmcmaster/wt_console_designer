import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_layout.freezed.dart';
part 'item_layout.g.dart';

@freezed
class ItemLayout with _$ItemLayout {
  ItemLayout._();
  factory ItemLayout({
    @JsonKey(name: 'point', fromJson: ItemLayout.pointFromJson, toJson: ItemLayout.pointToJson)
        required Point<double> point,
    @JsonKey(name: 'size', fromJson: ItemLayout.sizeFromJson, toJson: ItemLayout.sizeToJson)
        required Size size,
    @JsonKey(name: 'color', fromJson: ItemLayout.colorFromJson, toJson: ItemLayout.colorToJson)
    @Default(Colors.white)
        Color color,
    @JsonKey(name: 'selected') @Default(false) bool selected,
    @JsonKey(name: 'highlighted') @Default(false) bool highlighted,
  }) = _ItemLayout;
  factory ItemLayout.fromJson(Map<String, Object?> json) => _$ItemLayoutFromJson(json);

  static Map<String, dynamic> pointToJson(Point point) {
    return {
      'x': point.x,
      'y': point.y,
    };
  }

  static Point<double> pointFromJson(Map<String, dynamic> map) {
    return Point<double>(
      ((map['x'] ?? 0.0) as num).toDouble(),
      ((map['y'] ?? 0.0) as num).toDouble(),
    );
  }

  static Map<String, dynamic> sizeToJson(Size size) {
    return {
      'width': size.width,
      'height': size.height,
    };
  }

  static Size sizeFromJson(Map<String, dynamic> map) {
    return Size(
      ((map['width'] ?? 0.0) as num).toDouble(),
      ((map['height'] ?? 0.0) as num).toDouble() ?? 0.0,
    );
  }

  static Color colorFromJson(int value) {
    return Color(value);
  }

  static int colorToJson(Color color) {
    return color.value;
  }

  Rectangle<double> get bounds => Rectangle(
        point.x,
        point.y,
        size.width,
        size.height,
      );
}
