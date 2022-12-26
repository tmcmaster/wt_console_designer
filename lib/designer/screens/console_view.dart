import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_console_designer/designer/providers/item_list.dart';
import 'package:wt_console_designer/designer/providers/item_widget_factory.dart';
import 'package:wt_logging/wt_logging.dart';

class ConsoleView extends ConsumerWidget {
  static final log = logger(ConsoleView, level: Level.warning);

  const ConsoleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.v('Building widget');

    final items = ref.watch(itemListProvider);
    final factory = ref.read(itemWidgetFactoryProvider);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.grey,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.grey),
              onPressed: () {
                HiddenDrawerOpener.of(context)?.open();
              },
            ),
            title: const Text('Console'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                  onPressed: () {
                    ref.read(itemListProvider.notifier).load();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/paper-texture.png'),
                    // repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
              ...items
                  .map((item) => Positioned(
                        left: item.layout.point.x,
                        top: item.layout.point.y,
                        width: item.layout.size.width,
                        height: item.layout.size.height,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey.shade400,
                          )),
                          child: factory.createWidget(item),
                        ),
                      ))
                  .toList(),
            ],
          )),
    );
  }
}
