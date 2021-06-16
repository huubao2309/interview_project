import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/data/repository/login_repository.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/event/login/login_event.dart';
import 'package:interview_project/event/login/login_fail_event.dart';
import 'package:interview_project/event/login/login_success_event.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';

class LoginBloc extends BaseBloc with ChangeNotifier {
  LoginBloc({required LoginRepository loginRepository}) {
    _loginRepository = loginRepository;
  }

  late LoginRepository _loginRepository;

  final _userNameSubject = BehaviorSubject<String>();

  Stream<String> get userNameStream => _userNameSubject.stream;

  Sink<String> get userNameSink => _userNameSubject.sink;

  final _passwordSubject = BehaviorSubject<String>();

  Stream<String> get passwordStream => _passwordSubject.stream;

  Sink<String> get passwordSink => _passwordSubject.sink;

  final _btnLoginSubject = BehaviorSubject<bool>();

  Stream<bool> get btnLoginStream => _btnLoginSubject.stream;

  Sink<bool> get btnLoginSink => _btnLoginSubject.sink;

  final _strVersionSubject = BehaviorSubject<String>();

  Stream<String> get strVersionStream => _strVersionSubject.stream;

  Sink<String> get strVersionSink => _strVersionSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case LoginEvent:
        final e = event as LoginEvent;
        handleLogin(e);
        break;
    }
  }

  void handleLogin(LoginEvent e) {
    btnLoginSink.add(false); // When Start call api => Disable Login Button
    loadingSink.add(true); // Show loading

    if (e.username.isEmpty) {
      btnLoginSink.add(true); // Result is not null => Enable Button
      loadingSink.add(false); // Hide loading
      processEventSink.add(LoginFailEvent(tr('pleaseInputUserName')));
    } else if (e.password.isEmpty) {
      btnLoginSink.add(true); // Result is not null => Enable Button
      loadingSink.add(false); // Hide loading
      processEventSink.add(LoginFailEvent(tr('pleaseInputPassword')));
    } else {
      _loginRepository.login(username: e.username, password: e.password).asStream().first.then(
        (result) {
          if (result.isNotEmpty) {
            // Save token
            SPref.instance.set(SPrefCache.KEY_ACCESS_TOKEN, result);
            SPref.instance.set(SPrefCache.USER_NAME, e.username);
            processEventSink.add(LoginSuccessEvent(token: result));
          } else {
            processEventSink.add(LoginFailEvent(tr('errorLogin'))); // Notify Result
          }
          btnLoginSink.add(true); // Result is not null => Enable Button
          loadingSink.add(false); // Hide loading
        },
        onError: (e) {
          print(e);
          btnLoginSink.add(true); // Result is not null => Enable Button
          loadingSink.add(false); // Hide loading
          processEventSink.add(LoginFailEvent(tr('errorLogin'))); // Notify Result
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();

    _userNameSubject.close();
    _passwordSubject.close();
    _btnLoginSubject.close();
    _strVersionSubject.close();
  }
}
