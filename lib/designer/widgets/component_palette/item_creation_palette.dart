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
            PaletteItem(
              label: 'Icon',
              icon: FontAwesomeIcons.icons,
              item: IconItem(
                id: '',
                layout: ItemLayout(
                  point: const Point(50, 50),
                  size: const Size(50, 50),
                  color: Colors.white,
                ),
                state: IconItemState(
                  icon: Icons.person,
                ),
              ),
            ),
            PaletteItem(
              label: 'Switch',
              icon: Icons.toggle_on,
              item: SwitchItem(
                id: '',
                layout: ItemLayout(
                  point: const Point(50, 50),
                  size: const Size(100, 50),
                  color: Colors.white,
                ),
                state: SwitchItemState(
                  enabled: true,
                ),
              ),
            ),
            PaletteItem(
              label: 'Slider',
              icon: FontAwesomeIcons.listCheck,
              item: SliderItem(
                id: '',
                layout: ItemLayout(
                  point: const Point(50, 50),
                  size: const Size(150, 50),
                  color: Colors.white,
                ),
                state: SliderItemState(
                  min: 0.0,
                  max: 1.0,
                  value: 0.4,
                ),
              ),
            ),
            PaletteItem(
              label: 'Info',
              icon: FontAwesomeIcons.info,
              item: InfoItem(
                id: '',
                layout: ItemLayout(
                  point: const Point(50, 50),
                  size: const Size(200, 50),
                  color: Colors.white,
                ),
                state: InfoItemState(
                  value: ':-)',
                ),
              ),
            ),
            PaletteItem(
              label: 'Select',
              icon: Icons.arrow_drop_down,
              item: SelectItem(
                id: '',
                layout: ItemLayout(
                  point: const Point(50, 50),
                  size: const Size(150, 100),
                  color: Colors.white,
                ),
                state: SelectItemState(
                  options: ['one', 'two', 'three'],
                  value: 'one',
                ),
              ),
            ),
          ]
              .map(
                (palette) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TemplateItem(
                    label: palette.label,
                    icon: palette.icon,
                    item: palette.item,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
