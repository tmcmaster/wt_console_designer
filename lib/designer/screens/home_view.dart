import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/widgets/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/header_toolbar.dart';
import 'package:wt_console_designer/scroll_pane_2/scroll_pane.dart';

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
                    child: ScrollPane(),
                    // child: ScrollPane(
                    //   child: DesignerStack(),
                    // ),
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
