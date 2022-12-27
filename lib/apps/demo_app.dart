import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_console_designer/designer/screens/console_view.dart';
import 'package:wt_console_designer/designer/screens/home_view.dart';
import 'package:wt_console_designer/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() async {
  runMyApp(
    withFirebase(
      (_, __) async {
        return const ProviderScope(child: DemoApp());
      },
      appName: 'wt-console-designer',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}

class DemoApp extends StatelessWidget {
  const DemoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          final aspect = (constraints.maxHeight / constraints.minWidth);
          return Scaffold(
            backgroundColor: Colors.white,
            body: aspect < 1
                ? Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: DesignerApp(),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ConsoleApp(),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ControllerApp(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: DesignerApp(),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: const [
                            Expanded(
                              flex: 1,
                              child: ConsoleApp(),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 1,
                              child: ControllerApp(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class ControllerApp extends StatelessWidget {
  const ControllerApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      title: 'Controller',
      device: Devices.ios.iPhone13,
      child: const Center(
        child: Text('Controller'),
      ),
    );
  }
}

class ConsoleApp extends StatelessWidget {
  const ConsoleApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      title: 'Console',
      device: Devices.ios.iPhone13,
      child: const ConsoleView(),
    );
  }
}

class DesignerApp extends StatelessWidget {
  const DesignerApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      title: 'Designer',
      device: Devices.ios.iPad,
      child: const HomeView(),
    );
  }
}

class ScaffoldApp extends StatelessWidget {
  final String title;
  final DeviceInfo device;
  final Widget child;

  const ScaffoldApp({
    super.key,
    required this.title,
    required this.device,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(title),
      ),
      body: DevicePreview(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          home: Scaffold(
            body: child,
          ),
        ),
        isToolbarVisible: false,
        defaultDevice: device,
      ),
    );
  }
}
