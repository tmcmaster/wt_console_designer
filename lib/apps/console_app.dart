import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_console_designer/designer/screens/console_view.dart';
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
    appName: 'Console',
    appTitle: 'Console',
    appDetailsProvider: appDetailsProvider,
    swipeEnabled: false,
    applicationType: ApplicationType.bottomNavBar,
    pages: [
      PageDefinition(
        title: 'Console',
        icon: FontAwesomeIcons.tablet,
        primary: true,
        landing: true,
        builder: (_, __, ___) => const ConsoleView(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (_, __, ___) => const SettingsPage(),
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

final appStyles = Provider(
  name: 'AppStyles',
  (ref) => AppStyles(),
);
