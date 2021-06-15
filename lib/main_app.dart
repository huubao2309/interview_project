
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/module/home/home_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:interview_project/shared_code/theme/theme_type.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/common.dart';
import 'module/login/login_page.dart';
import 'module/navigation_bottom_page.dart';
import 'module/setting/setting_page.dart';
import 'module/splash_screen/splash_screen.dart';
import 'shared_code/dialog_manager/managers/dialog_manager.dart';
import 'shared_code/utils/materials/system.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    platformDevice = Theme.of(context).platform;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context)!.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Provider.of<ThemeState>(context).setColorTheme(),
      initialRoute: Navigator.defaultRouteName,
      builder: (context, widget) => Navigator(
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(
            child: widget,
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        Navigator.defaultRouteName: (context) => SplashPage(),
        Route_Named_LoginPage: (context) => LoginPage(),
        Route_Named_NavigatePage: (context) => const MyNavPage(),
        Route_Named_HomePage: (context) => HomePage(),
        Route_Named_SettingPage: (context) => SettingPage(),
      },
    );
  }
}
