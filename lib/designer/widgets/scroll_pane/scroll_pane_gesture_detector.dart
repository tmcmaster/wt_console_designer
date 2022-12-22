part of 'scroll_pane.dart';

class DragAndPanDetector extends ConsumerWidget {
  static final log = logger(DragAndPanDetector, level: Level.warning);

  const DragAndPanDetector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(scrollPaneStateProvider.notifier);
    final selection = ref.read(selectionProvider.notifier);

    final itemsNotifier = ref.read(itemListProvider.notifier);

    return kIsWeb || Platform.isIOS
        ? _DragAndPanDetectorWeb(
            onDeselect: () => onDeselect(itemsNotifier),
            onSelecting: (region) => onSelecting(selection, region),
            onSelected: (region) => onSelected(selection, region),
            onPanning: (offset) => onPanning(notifier, offset),
          )
        : _DragAndPanDetectorMacos(
            onDeselect: () => onDeselect(itemsNotifier),
            onSelecting: (region) => onSelecting(selection, region),
            onSelected: (region) => onSelected(selection, region),
            onPanning: (offset) => onPanning(notifier, offset),
          );
  }

  void onDeselect(ItemListNotifier itemsNotifier) {
    log.d('DragAndPanDetector : Deselecting');
    itemsNotifier.clearSelection();
  }

  void onSelecting(SelectionStateNotifier selection, Rectangle<double> region) {
    log.d('DragAndPanDetector Selecting: $region');
    selection.setRegion(region);
  }

  void onSelected(SelectionStateNotifier selection, Rectangle<double> region) {
    log.d('DragAndPanDetector Selected: $region');
    selection.end();
    selection.clear();
  }

  onPanning(ScrollPaneStateNotifier notifier, Offset offset) {
    log.v('DragAndPanDetector Panning: $offset');
    notifier.movePoint(offset);
  }
}

class _DragAndPanState {
  bool pan = true;
  Offset? start;
  Offset? end;
}

abstract class _DragAndPanDetectorBase extends StatelessWidget {
  final void Function(Rectangle<double>)? onSelecting;
  final void Function(Rectangle<double>)? onSelected;
  final void Function(Offset)? onPanning;
  final void Function()? onDeselect;

  final _DragAndPanState state = _DragAndPanState();

  _DragAndPanDetectorBase({
    this.onSelecting,
    this.onSelected,
    this.onPanning,
    this.onDeselect,
  });

  Rectangle<double> createRegion(Offset start, Offset end) {
    final left = start.dx < end.dx ? start.dx : end.dx;
    final right = start.dx < end.dx ? end.dx : start.dx;
    final top = start.dy < end.dy ? start.dy : end.dy;
    final bottom = start.dy < end.dy ? end.dy : start.dy;
    return Rectangle(left, top, right - left, bottom - top);
  }
}

class _DragAndPanDetectorWeb extends _DragAndPanDetectorBase {
  static final log = logger(_DragAndPanDetectorWeb, level: Level.warning);

  _DragAndPanDetectorWeb({
    super.onSelecting,
    super.onSelected,
    super.onPanning,
    super.onDeselect,
  });

  @override
  Widget build(BuildContext context) {
    log.d('Building Widget');
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTap: () {
          log.v('Tap : ');
          onDeselect?.call();
        },
        onTapDown: (details) {
          log.v('Tap Down : ');
          state.pan = true;
          state.start = details.localPosition;
        },
        onPanUpdate: (details) {
          log.v("Pan Update : ");
          if (state.start != null) {
            onPanning?.call(details.delta);
          }
        },
        onPanEnd: (details) {
          log.v("Pan End : ");
          state.pan = false;
        },
        onLongPressStart: (details) {
          log.v('onLongPressStart(${details.localPosition})');
          state.pan = false;
          state.start = details.localPosition;
        },
        onLongPressMoveUpdate: (details) {
          log.v('onLongPressMoveUpdate(${details.localPosition})');

          state.end = details.localPosition;
          onSelecting?.call(createRegion(state.start!, state.end!));
        },
        onLongPressEnd: (details) {
          log.v('onLongPressMoveUpdate(${details.localPosition})');
          onSelected?.call(createRegion(state.start!, state.end!));
          state.start = null;
          state.end = null;
        },
      ),
    );
  }
}

class _DragAndPanDetectorMacos extends _DragAndPanDetectorBase {
  static final log = logger(_DragAndPanDetectorMacos, level: Level.warning);

  _DragAndPanDetectorMacos({
    super.onSelecting,
    super.onSelected,
    super.onPanning,
    super.onDeselect,
  });

  @override
  Widget build(BuildContext context) {
    log.d('Building Widget');
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTap: () {
          log.v('Tap : ');
          onDeselect?.call();
        },
        onTapDown: (details) {
          log.v('Tap Down : ');
          state.pan = false;
          state.start = details.localPosition;
        },
        // onTapUp: (details) {
        //   // print('Tap Up : ');
        //   pan = true;
        // },
        onPanEnd: (details) {
          if (!state.pan && state.start != null && state.end != null) {
            onSelected?.call(createRegion(state.start!, state.end!));
          }
          log.v("Pan End : ");
          state.pan = true;
        },
        onPanUpdate: (details) {
          if (state.pan) {
            log.v("Pan Update : ");
            onPanning?.call(details.delta);
          } else {
            log.v("Drag Update : ");
            state.end = details.localPosition;
            onSelecting?.call(createRegion(state.start!, state.end!));
          }
        },
      ),
    );
  }
}
