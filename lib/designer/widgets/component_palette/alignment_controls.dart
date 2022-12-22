part of 'component_palette.dart';

class AlignmentControls extends ConsumerWidget {
  const AlignmentControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(selectedItems);
    final itemListNotifier = ref.read(itemListProvider.notifier);

    final Map<IconData, void Function(List<Item>)> actions = {
      Icons.align_horizontal_center: itemListNotifier.horizontalCenterAlign,
      Icons.align_horizontal_left: itemListNotifier.leftAlign,
      Icons.align_horizontal_right: itemListNotifier.rightAlign,
      Icons.align_vertical_center: itemListNotifier.verticalCenterAlign,
      Icons.align_vertical_top: itemListNotifier.topAlign,
      Icons.align_vertical_bottom: itemListNotifier.bottomAlign,
    };

    return Column(
      children: actions.entries
          .map(
            (entry) => IconButton(
              onPressed: () {
                entry.value(items);
              },
              icon: Icon(
                entry.key,
                color: Colors.grey.shade800,
              ),
            ),
          )
          .toList(),
    );
  }
}
