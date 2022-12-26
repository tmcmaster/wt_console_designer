import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_console_designer/designer/screens/console_view.dart';
import 'package:wt_console_designer/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
        appDefinition: appDefinitionProvider,
        appDetails: appDetailsProvider,
        loginSupport: const LoginSupport(
          emailEnabled: true,
        ),
      ),
      appName: 'wt-console-designer',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}

final appDefinitionProvider = Provider<AppDefinition>(
  name: 'AppDefinition',
  (ref) => AppDefinition.from(
    appName: 'Console',
    appTitle: 'Console',
    appDetailsProvider: appDetailsProvider,
    pages: [
      PageDefinition(
        title: 'Console',
        icon: FontAwesomeIcons.tablet,
        builder: (_) => const ConsoleView(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (_) => const SettingsPage(),
      )
    ],
  ),
);

final appDetailsProvider = Provider(
  name: 'AppDetails',
  (ref) => AppDetails(
    title: 'Console',
    subTitle: 'Useful for Something',
    iconPath: 'assets/icon.png',
  ),
);
