import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/event/logout/logout_event.dart';
import 'package:interview_project/event/logout/logout_sucess_event.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/dialog_manager/locator.dart';
import 'package:interview_project/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';
import 'package:interview_project/shared_code/utils/methods/common_method.dart';
import 'package:rxdart/rxdart.dart';

class SettingBloc extends BaseBloc with ChangeNotifier {
  SettingBloc() {
    loadUserNameApp();
    loadVersionApp();
  }

  final DialogService _dialogService = locator<DialogService>();

  final _loadVersionSubject = BehaviorSubject<String?>();

  Stream<String?> get loadVersionStream => _loadVersionSubject.stream;

  Sink<String?> get loadVersionSink => _loadVersionSubject.sink;

  final _loadFullNameSubject = BehaviorSubject<String?>();

  Stream<String?> get loadFullNameStream => _loadFullNameSubject.stream;

  Sink<String?> get loadFullNameSink => _loadFullNameSubject.sink;

  Future<void> loadUserNameApp() async {
    const fullName = 'Anonymous';
    loadFullNameSink.add(fullName);
  }

  Future<void> loadVersionApp() async {
    final projectVersion = await SPref.instance.get(SPrefCache.PROJECT_VERSION);
    loadVersionSink.add(projectVersion);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  void handleLogout(LogoutEvent event) {
    loadingSink.add(true); // Show loading
    processEventSink.add(LogoutSuccessEvent());
    hasLogout = true;

    // clear Cache
    clearSPrefCache();
  }

  Future<void> doShowDialog(
      {required String description, BaseEvent? event, String title = '', String typeDialog = ''}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title.isNotEmpty ? title : tr('Info'),
      description: description,
      typeDialog: typeDialog.isNotEmpty ? typeDialog : DIALOG_TWO_BUTTON,
    );

    if (dialogResult.confirmed) {
      handleEventDialog(event);
    } else {
      print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent? event) {
    switch (event.runtimeType) {
      case LogoutEvent:
        final e = event as LogoutEvent;
        handleLogout(e);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _loadVersionSubject.close();
    _loadFullNameSubject.close();
  }
}
