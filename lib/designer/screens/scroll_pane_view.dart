import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/widgets/scroll_pane/scroll_pane.dart';

class ScrollPaneView extends StatelessWidget {
  const ScrollPaneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.blue,
        child: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: ScrollPane(),
          );
        }),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  static const colors = [
    Colors.amber,
    Colors.indigo,
    Colors.teal,
    Colors.cyan,
    Colors.yellow,
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.red,
  ];

  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Building TestWidget');
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(4),
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      crossAxisCount: 3,
      children: colors
          .map((color) => Container(
                padding: const EdgeInsets.all(20),
                color: color.shade200,
                child: Center(
                  child: Text(color.toString()),
                ),
              ))
          .toList(),
    );
    ;
  }
}
