part of 'scroll_pane.dart';

class DragAndPanDetector extends StatelessWidget {
  static final log = logger(DragAndPanDetector, level: Level.debug);

  final void Function(Rectangle<double>)? onSelecting;
  final void Function(Rectangle<double>)? onSelected;
  final void Function(Offset)? onPanning;
  final void Function()? onDeselect;

  DragAndPanDetector({
    super.key,
    this.onSelecting,
    this.onSelected,
    this.onPanning,
    this.onDeselect,
  });

  bool pan = true;
  Offset? start;
  Offset? end;

  @override
  Widget build(BuildContext context) {
    log.d('Building Widget');
    return GestureDetector(
      onTap: () {
        onDeselect?.call();
      },
      onTapDown: (details) {
        log.v('Tap Down : ');
        pan = false;
        start = details.localPosition;
      },
      // onTapUp: (details) {
      //   // print('Tap Up : ');
      //   pan = true;
      // },
      onPanEnd: (details) {
        if (!pan) {
          onSelected?.call(_createRegion(start!, end!));
        }
        log.v("Pan End : ");
        pan = true;
      },
      onPanUpdate: (details) {
        if (pan) {
          log.v("Pan Update : ");
          onPanning?.call(details.delta);
        } else {
          log.v("Drag Update : ");
          end = details.localPosition;
          onSelecting?.call(_createRegion(start!, end!));
        }
      },
    );
  }

  Rectangle<double> _createRegion(Offset start, Offset end) {
    final left = start.dx < end.dx ? start.dx : end.dx;
    final right = start.dx < end.dx ? end.dx : start.dx;
    final top = start.dy < end.dy ? start.dy : end.dy;
    final bottom = start.dy < end.dy ? end.dy : start.dy;
    return Rectangle(left, top, right - left, bottom - top);
  }
}
