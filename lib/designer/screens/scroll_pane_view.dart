import 'package:flutter/material.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane.dart';

class ScrollPaneView extends StatelessWidget {
  const ScrollPaneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        color: Colors.blue,
        child: const ScrollPane(
          canScale: true,
          child: TestWidget(),
        ),
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building TestWidget');
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Testing'),
    );
  }
}
//
// class ScrollPaneStack extends StatelessWidget {
//   final List<Widget> children;
//
//   ScrollPaneStack({
//     super.key,
//     required this.children,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     print('Building ScrollPaneStack');
//     return Stack(
//       children: children,
//     );
//   }
// }
