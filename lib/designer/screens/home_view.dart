import 'package:flutter/material.dart';
import 'package:wt_console_designer/designer/screens/scroll_pane_view.dart';
import 'package:wt_console_designer/designer/widgets/component_palette/component_palette.dart';
import 'package:wt_console_designer/designer/widgets/header_toolbar.dart';
import 'package:wt_logging/wt_logging.dart';

class HomeView extends StatelessWidget {
  static final log = logger(HomeView, level: Level.warning);

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    log.v('Building widget');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderToolBar(),
            Expanded(
              child: Row(
                children: const [
                  ComponentPalette(),
                  Expanded(
                    child: ScrollPaneView(),
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
