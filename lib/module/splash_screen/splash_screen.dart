import 'package:device_info/device_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/common/define_image.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/theme/theme_type.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:interview_project/shared_code/utils/methods/common_method.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared_code/utils/materials/app_color.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PublishSubject loadConfigurePublishSubject = PublishSubject<dynamic>();
  final deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _startApp();
    checkPermission();
    _listenConfigureApp();
  }

  @override
  void dispose() {
    super.dispose();
    loadConfigurePublishSubject.close();
  }

  Future<void> _startApp() async {
    await _loadThemeApp();
    await _loadLanguageApp();
    await _checkLogin();
  }

  Future<void> _loadThemeApp() async {
    var themeApp = await SPref.instance.get(SPrefCache.THEME_APP);
    if (themeApp == null || themeApp.toString().isEmpty) {
      themeApp = LIGHT_THEME; // Default Light Mode
      await SPref.instance.set(SPrefCache.THEME_APP, themeApp);
    }
    Provider.of<ThemeState>(context, listen: false).theme = themeApp == LIGHT_THEME ? ThemeType.LIGHT : ThemeType.DARK;
  }

  Future<void> _loadLanguageApp() async {
    final languageApp = await SPref.instance.getOrDefault(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);
    if (languageApp == null || languageApp.toString().isEmpty) {
      await SPref.instance.set(SPrefCache.LANGUAGE_APP, VIETNAMESE_LANGUAGE);
    }
    final languageLocate = languageApp == VIETNAMESE_LANGUAGE
        ? EasyLocalization.of(context)!.supportedLocales[0] // Vietnam
        : EasyLocalization.of(context)!.supportedLocales[1]; // English
    await EasyLocalization.of(context)!.setLocale(languageLocate);
  }

  Future<void> _checkLogin() async {
    final token = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);

    // print Token in console
    printWrappedLog('Token: $token');
    loadConfigurePublishSubject.add(token);
  }

  void _listenConfigureApp() {
    // Delay 1s
    loadConfigurePublishSubject.stream.delay(const Duration(seconds: 1)).listen((value) {
      if (value != null && value.toString().isNotEmpty) {
        print('Navigate Splash Screen to Home Page');
        Navigator.pushReplacementNamed(context, Route_Named_NavigatePage);
        return;
      }
      print('Navigate to Login Page');
      Navigator.pushReplacementNamed(context, Route_Named_LoginPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    sizeDevice = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primaryBackgroundColor,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('${PATH_IMAGE}bg_welcome.png'),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(
                      '${PATH_IMAGE}ic_logo_app.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.scaleDown,
                    ),
                    const Spacer(),
                    const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      semanticsLabel: 'Loading',
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '© 2021 - Designed by ',
                            style: TextStyle(
                              color: AppColor.primaryHintColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'BaoNH',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
