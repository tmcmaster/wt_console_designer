import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/screens/home_view.dart';
import 'package:wt_console_designer/designer/widgets/scroll_pane/scroll_pane.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: ConsoleDesignerApp(),
    ),
  );
}

class ConsoleDesignerApp extends StatelessWidget {
  static const bool _testParabeacThemes = false;

  const ConsoleDesignerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      // theme: _testParabeacThemes
      //     ? FlutterThemesTheme.themeDataLight
      //     : ThemeData(
      //         primarySwatch: Colors.blue,
      //       ),
      // darkTheme: _testParabeacThemes ? FlutterThemesTheme.themeDataDark : ThemeData.dark(),
      // home: const TestApp(),
      home: HomeScreen(),
      // home: const ScrollPaneView(),
    );
  }
}

class TestApp extends StatelessWidget {
  static final log = logger(TestApp, level: Level.debug);

  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    log.d('Building Widget.');
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(50),
          child: ScrollPane(),
        ),
      ),
    );
  }
}
