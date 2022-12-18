import 'dart:math';
import 'dart:ui';

import 'package:wt_console_designer/designer/models/item_type.dart';

class Item {
  final String id;
  final ItemType type;
  final Point point;
  final Size size;
  final Color color;
  final bool selected;
  final bool highlighted;
  final double? aspect;
  final bool resize;

  Item({
    required this.id,
    required this.type,
    required this.point,
    required this.size,
    required this.color,
    required this.selected,
    required this.highlighted,
    this.aspect,
    this.resize = true,
  });

  Item copyWith({
    String? id,
    ItemType? type,
    Point? point,
    Size? size,
    Color? color,
    bool? selected,
    bool? highlighted,
    double? aspect,
    bool? resize,
  }) {
    return Item(
      id: id ?? this.id,
      type: type ?? this.type,
      point: point ?? this.point,
      size: size ?? this.size,
      color: color ?? this.color,
      selected: selected ?? this.selected,
      highlighted: highlighted ?? this.highlighted,
      aspect: aspect ?? this.aspect,
      resize: resize ?? this.resize,
    );
  }

  Rectangle get bounds => Rectangle(
        point.x,
        point.y,
        size.width,
        size.height,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'point': {
        'x': point.x,
        'y': point.y,
      },
      'size': {
        'width': size.width,
        'height': size.height,
      },
      'color': color.value,
      'selected': selected,
    };
  }

  @override
  String toString() {
    return 'Item(id:$id, Point(${point.x},${point.y}))';
  }

  static Item fromJson(Map<String, dynamic> map) {
    final pointMap = (map['point'] ?? {}) as Map<String, dynamic>;
    final sizeMap = (map['size'] ?? {}) as Map<String, dynamic>;

    return Item(
      id: (map['id'] ?? ""),
      type: ItemType.values[map['type']],
      point: Point(
        (pointMap['x'] ?? -1) + 0.0,
        (pointMap['y'] ?? -1) + 0.0,
      ),
      size: Size(
        (sizeMap['width'] ?? -1) + 0.0,
        (sizeMap['height'] ?? -1) + 0.0,
      ),
      color: Color((map['color'] ?? 4294961979) as int),
      selected: map['selected'] == 'true',
      highlighted: map['highlighted'] == 'true',
      aspect: map['aspect'] == null ? null : (map['aspect'] + 1.0),
      resize: map['resize'] == 'true',
    );
  }
}
