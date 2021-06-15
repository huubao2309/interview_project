import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_widget.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/service/login_service/login_service.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/event/logout/logout_event.dart';
import 'package:interview_project/event/logout/logout_sucess_event.dart';
import 'package:interview_project/module/login/login_page.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/style/text_style/txt_style.dart';
import 'package:interview_project/shared_code/theme/theme_type.dart';
import 'package:interview_project/shared_code/utils/materials/app_color.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/materials/system.dart';
import 'package:interview_project/shared_code/widgets/appbar_widget/app_bar_widget.dart';
import 'package:interview_project/shared_code/widgets/base_widget/bloc_listener.dart';
import 'package:interview_project/shared_code/widgets/dialog_widget/chosen_language_dialog.dart';
import 'package:interview_project/shared_code/widgets/switch_widget/switch_widget.dart';
import 'package:provider/provider.dart';

import 'setting_bloc.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [
        Provider.value(
          value: LoginService(),
        ),
      ],
      bloc: const [],
      child: SettingPageWidget(),
    );
  }
}

class SettingPageWidget extends StatefulWidget {
  @override
  _SettingPageWidgetState createState() => _SettingPageWidgetState();
}

class _SettingPageWidgetState extends State<SettingPageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingBloc(),
      child: Consumer<SettingBloc>(
        builder: (context, bloc, child) => BlocListener<SettingBloc>(
          listener: handleEvent,
          child: Scaffold(
            appBar: AppBarWidget(
              title: tr('Setting'),
              isVisibleBackButton: false,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // Vertical
                children: <Widget>[
                  const SizedBox(height: 20),
                  _buildInfoUserWidget(bloc),
                  _buildChangeThemeSupportWidget(bloc),
                  _buildChangeLanguageSettingWidget(),
                  _buildLogoutSettingWidget(bloc),
                  _buildVersionWidget(bloc),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoUserWidget(SettingBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.loadFullNameStream,
      catchError: (context, err) {
        print('Error List');
        return err.toString();
      },
      child: Consumer<String?>(
        builder: (context, data, child) {
          return Container(
            width: sizeDevice.width,
            margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
            child: Card(
              color: AppColor.primaryBackgroundColor,
              elevation: 4,
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 10, right: 8, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: CircleAvatar(
                        backgroundColor: AppColor.primaryColor,
                        child: Icon(
                          Icons.account_circle,
                          color: AppColor.colorWhite,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      data ?? tr('no_name'),
                      style: SubTextStyle.bold(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChangeThemeSupportWidget(SettingBloc bloc) {
    return Container(
      width: sizeDevice.width,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
      child: Card(
        color: AppColor.primaryBackgroundColor,
        elevation: 4,
        child: Column(
          children: [
            // _buildChangeThemeSettingWidget(),
            // const Divider(height: 1, color: Colors.grey),
            _buildSupportCenterWidget(bloc),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _buildChangeThemeSettingWidget() {
    final themApp = Provider.of<ThemeState>(context).theme;
    var _isDarkMode = themApp == ThemeType.DARK;
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 1, bottom: 1),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              radius: 66,
              child: Icon(
                Icons.battery_charging_full,
                color: AppColor.colorWhite,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(tr('darkTheme'), style: SubTextStyle.bold()),
          const Spacer(),
          SwitchWidget(
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
                // Change Theme
                Provider.of<ThemeState>(context, listen: false).theme = _isDarkMode == false ? ThemeType.LIGHT : ThemeType.DARK;

                // Save Cache
                SPref.instance.set(SPrefCache.THEME_APP, _isDarkMode == false ? LIGHT_THEME : DARK_THEME);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCenterWidget(SettingBloc bloc) {
    return GestureDetector(
      onTap: () {
        bloc.doShowDialog(description: 'connect_contact'.tr(args: [HOT_LINE]), typeDialog: DIALOG_CONGRATULATE_BUTTON);
      },
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(left: 15, top: 10, right: 8, bottom: 10),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              child: CircleAvatar(
                backgroundColor: AppColor.primaryColor,
                radius: 66,
                child: Icon(
                  Icons.support_agent,
                  color: AppColor.colorWhite,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(tr('support_center'), style: SubTextStyle.bold()),
            const Spacer(),
            Icon(Icons.navigate_next, color: AppColor.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildChangeLanguageSettingWidget() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => const ChosenLanguageDialog(),
        );
      },
      child: Container(
        width: sizeDevice.width,
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
        child: Card(
          color: AppColor.primaryBackgroundColor,
          elevation: 4,
          child: Container(
            margin: const EdgeInsets.only(left: 15, top: 10, right: 8, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    radius: 66,
                    child: Icon(
                      Icons.lock,
                      color: AppColor.colorWhite,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(tr('language'), style: SubTextStyle.bold()),
                const Spacer(),
                Icon(Icons.navigate_next, color: AppColor.primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutSettingWidget(SettingBloc bloc) {
    return Container(
      width: sizeDevice.width,
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
      child: GestureDetector(
        onTap: () async {
          await bloc.doShowDialog(description: tr('LogoutMessage'), event: LogoutEvent());
        },
        child: Card(
          color: AppColor.primaryBackgroundColor,
          elevation: 4,
          child: Container(
            margin: const EdgeInsets.only(left: 15, top: 10, right: 8, bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    radius: 66,
                    child: Icon(
                      Icons.power_settings_new,
                      color: AppColor.colorWhite,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(tr('Logout'), style: SubTextStyle.bold()),
                const Spacer(),
                Icon(Icons.navigate_next, color: AppColor.primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVersionWidget(SettingBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: '',
      value: bloc.loadVersionStream,
      catchError: (context, err) {
        print('Error List');
        return err.toString();
      },
      child: Consumer<String?>(
        builder: (context, version, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('version'),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    version ?? '1.0.0',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '© 2021 - Designed by ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'BaoNH',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> handleEvent(BaseEvent event) async {
    if (event is LogoutSuccessEvent) {
      // Navigate to Login Page
      await Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
      return;
    }
    return;
  }
}
