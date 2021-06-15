import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

import 'config/Configuration.UAT.dart';
import 'main_app.dart';
import 'shared_code/dialog_manager/locator.dart';
import 'shared_code/theme/theme_type.dart';

Future<void> main() async {
  // Load Config for UAT
  GlobalConfiguration().loadFromMap(uatAppSettings);
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('vi', 'VN'), // index 0
        Locale('en', 'US'), // index 1
      ],
      path: 'lib/resources/translations',
      fallbackLocale: const Locale('vi', 'VN'),
      child: ChangeNotifierProvider(
        create: (context) => ThemeState(),
        child: MainApp(),
      ),
    ),
  );
}
