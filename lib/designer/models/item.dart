import 'dart:math';
import 'dart:ui';

class Item {
  final String id;
  final Point point;
  final Size size;
  final Color color;
  final bool selected;

  Item({
    required this.id,
    required this.point,
    required this.size,
    required this.color,
    required this.selected,
  });

  Item copyWith({
    String? id,
    Point? point,
    Size? size,
    Color? color,
    bool? selected,
  }) {
    return Item(
      id: id ?? this.id,
      point: point ?? this.point,
      size: size ?? this.size,
      color: color ?? this.color,
      selected: selected ?? this.selected,
    );
  }

  Rectangle get bounds => Rectangle(
        point.x,
        point.y,
        point.x + size.width,
        point.y + size.height,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
        point: Point(
          (pointMap['x'] ?? -1) + 0.0,
          (pointMap['y'] ?? -1) + 0.0,
        ),
        size: Size(
          (sizeMap['width'] ?? -1) + 0.0,
          (sizeMap['height'] ?? -1) + 0.0,
        ),
        color: Color((map['color'] ?? 4294961979) as int),
        selected: map['selected'] == 'true');
  }
}
