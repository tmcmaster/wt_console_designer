import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_console_designer/designer/screens/home_view.dart';
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
    appName: 'Console Designer',
    appTitle: 'Console Designer',
    appDetailsProvider: appDetailsProvider,
    pages: [
      PageDefinition(
        title: 'Designer',
        icon: FontAwesomeIcons.desktop,
        builder: (_) => const HomeView(),
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
    title: 'Console Designer',
    subTitle: 'Create and configure consoles',
    iconPath: 'assets/icon.png',
  ),
);
