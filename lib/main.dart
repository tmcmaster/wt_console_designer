import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_console_designer/designer/screens/home_view.dart';
import 'package:wt_console_designer/theme/flutter_themes_theme.g.dart';

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
      theme: _testParabeacThemes
          ? FlutterThemesTheme.themeDataLight
          : ThemeData(
              primarySwatch: Colors.amber,
            ),
      darkTheme: _testParabeacThemes ? FlutterThemesTheme.themeDataDark : ThemeData.dark(),
      home: HomeScreen(),
      // home: const ScrollPaneView(),
    );
  }
}
