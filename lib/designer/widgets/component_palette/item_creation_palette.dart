part of 'component_palette.dart';

class ItemCreationPalette extends StatelessWidget {
  const ItemCreationPalette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border(
          right: BorderSide(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...[
            const PaletteItem(
              label: 'Icon',
              type: ItemType.icon,
              icon: FontAwesomeIcons.icons,
              size: Size(50, 50),
            ),
            const PaletteItem(
              label: 'Toggle',
              type: ItemType.toggle,
              icon: Icons.toggle_on,
              size: Size(100, 50),
            ),
            const PaletteItem(
              label: 'Slider',
              type: ItemType.slider,
              icon: FontAwesomeIcons.listCheck,
              size: Size(150, 50),
            ),
            const PaletteItem(
              label: 'Info',
              type: ItemType.info,
              icon: FontAwesomeIcons.info,
              size: Size(200, 50),
            ),
            const PaletteItem(
              label: 'Select',
              type: ItemType.select,
              icon: Icons.arrow_drop_down,
              size: Size(150, 100),
            ),
          ]
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TemplateItem(
                    label: item.label,
                    icon: item.icon,
                    lottie: item.lottie,
                    item: Item(
                      id: '',
                      type: item.type,
                      highlighted: false,
                      selected: false,
                      point: const Point(100, 100),
                      size: item.size,
                      color: item.color,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
