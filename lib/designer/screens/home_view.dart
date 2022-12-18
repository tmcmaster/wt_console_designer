import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/widgets/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/designer_stack.dart';
import 'package:wt_console_designer/designer/widgets/header_toolbar.dart';
import 'package:wt_console_designer/scroll_pane/scroll_pane.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderToolBar(),
            Expanded(
              child: Row(
                children: [
                  const ComponentPalette(),
                  Expanded(
                    child: ScrollPane(
                      child: DesignerStack(),
                    ),
                  ),
                ],
              ),
            ),
            // const ItemConfiguration(),
          ],
        ),
      ),
    );
  }
}
