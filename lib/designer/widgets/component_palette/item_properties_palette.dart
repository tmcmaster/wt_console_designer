part of 'component_palette.dart';

class ItemPropertiesPalette extends ConsumerWidget {
  const ItemPropertiesPalette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListNotifier = ref.read(itemListProvider.notifier);
    final items = ref.watch(selectedItems);
    // final item = items[0];
    return Container(
      width: 75,
      padding: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          right: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            child: IconButton(
              onPressed: () {
                itemListNotifier.clearSelection();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey.shade800,
                size: 20,
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      pickerColor: items.isNotEmpty ? items[0].layout.color : Colors.white,
                      onColorChanged: (color) {
                        itemListNotifier.updateItems(items.map((item) {
                          final Item newItem = item.copyWith(
                            layout: item.layout.copyWith(color: color),
                          );
                          return newItem;
                        }).toList());
                      },
                    ),
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.color_lens,
              color: Colors.grey.shade800,
            ),
          ),
          if (items.length > 1) const AlignmentControls()
        ],
      ),
    );
  }
}
