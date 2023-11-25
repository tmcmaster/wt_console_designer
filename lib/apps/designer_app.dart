import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_console_designer/designer/screens/home_view.dart';
import 'package:wt_console_designer/firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
        appDefinition: appDefinitionProvider,
        appDetails: appDetailsProvider,
        appStyles: appStyles,
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
    swipeEnabled: false,
    pages: [
      PageDefinition(
        title: 'Designer',
        icon: FontAwesomeIcons.desktop,
        builder: (_, __, ___) => const HomeView(),
        primary: true,
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (_, __, ___) => const SettingsPage(),
        primary: true,
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

final appStyles = Provider(
  name: 'AppStyles',
  (ref) => AppStyles(),
);
