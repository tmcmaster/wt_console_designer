part of 'scroll_pane.dart';

class ScrollPaneSelectBox extends StatelessWidget {
  static final log = logger(ScrollPaneSelectBox, level: Level.debug);

  const ScrollPaneSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      top: 100,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
    );
  }
}
