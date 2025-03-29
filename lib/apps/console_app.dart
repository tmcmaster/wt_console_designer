import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_console_designer/designer/screens/console_view.dart';
import 'package:wt_console_designer/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
        appDefinition: appDefinition,
        appDetails: appDetails,
        appStyles: (Ref ref) => AppStyles(),
      ),
      appName: 'wt-console-designer',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}

final appDefinition = AppDefinition.from(
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
      builder: (_) => const ConsoleView(),
    ),
    PageDefinition(
      title: 'Settings',
      icon: Icons.settings,
      builder: (_) => const SettingsPage(),
    )
  ],
);

final appDefinitionProvider = Provider<AppDefinition>(
  name: 'AppDefinition',
  (ref) => appDefinition,
);

final appDetails = AppDetails(
  title: 'Console',
  subTitle: 'Useful for Something',
  iconPath: 'assets/icon.png',
);

final appDetailsProvider = Provider(
  name: 'AppDetails',
  (ref) => appDetails,
);

final appStyles = Provider(
  name: 'AppStyles',
  (ref) => AppStyles(),
);
