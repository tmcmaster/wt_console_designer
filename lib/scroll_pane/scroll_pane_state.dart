import 'dart:ui';

class ScrollPaneState {
  final Offset offset;
  final Size size;
  final double scale;
  final double scaleDelta;

  ScrollPaneState({
    required this.offset,
    required this.size,
    required this.scale,
    required this.scaleDelta,
  });

  ScrollPaneState copyWith({
    Offset? offset,
    Size? size,
    double? scale,
    double? scaleDelta,
  }) {
    return ScrollPaneState(
      offset: offset ?? this.offset,
      size: size ?? this.size,
      scale: scale ?? this.scale,
      scaleDelta: scaleDelta ?? this.scaleDelta,
    );
  }

  @override
  String toString() {
    return 'State(OffSet(${offset.dx},${offset.dy}), Size(${size.width},${size.height}), '
        'Scale($scale), ScaleDelta($scaleDelta)';
  }
}
