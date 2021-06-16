import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interview_project/data/repository/sign_up_repository.dart';
import 'package:interview_project/event/sign_up/sign_up_fail_event.dart';
import 'package:interview_project/event/sign_up/sign_up_success_event.dart';
import 'package:interview_project/shared_code/utils/helpers/validation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:interview_project/base/base_bloc.dart';
import 'package:interview_project/base/base_event.dart';
import 'package:interview_project/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:interview_project/shared_code/dialog_manager/locator.dart';
import 'package:interview_project/shared_code/dialog_manager/services/dialog_service.dart';

class SignUpBloc extends BaseBloc with ChangeNotifier {
  SignUpBloc({required SignUpRepository signUpRepository}) {
    _signUpRepository = signUpRepository;
    _validateForm();
  }

  final DialogService _dialogService = locator<DialogService>();

  late SignUpRepository _signUpRepository;

  final checkInputUserNameValidation = StreamTransformer<String?, String?>.fromHandlers(handleData: (name, sink) {
    if (name == null || name.isEmpty) {
      sink.add(null);
      return;
    }

    sink.add(null);
  });

  final _inputUserNameSubject = BehaviorSubject<String?>();

  Stream<String?> get inputUserNameStream => _inputUserNameSubject.stream.transform(checkInputUserNameValidation);

  Sink<String?> get inputUserNameSink => _inputUserNameSubject.sink;

  final newPassWordValidation = StreamTransformer<String?, String?>.fromHandlers(handleData: (password, sink) {
    if (Validation.isPassValid(password)) {
      sink.add(null);
      return;
    }
    sink.add(tr('errorPassword'));
  });

  final _newInputPasswordSubject = BehaviorSubject<String?>();

  Stream<String?> get newInputPasswordStream => _newInputPasswordSubject.stream.transform(newPassWordValidation);

  Sink<String?> get newInputPasswordSink => _newInputPasswordSubject.sink;

  final _reNewInputPasswordSubject = BehaviorSubject<String>();

  Stream<String?> get reNewInputPasswordStream => Rx.combineLatest2(
        _newInputPasswordSubject,
        _reNewInputPasswordSubject,
        (newInputPass, reNewInputPass) => _matchNewPassword(
          newInputPassword: newInputPass as String?,
          reNewInputPassword: reNewInputPass as String?,
        ),
      );

  Sink<String> get reNewInputPasswordSink => _reNewInputPasswordSubject.sink;

  String? _matchNewPassword({required String? newInputPassword, required String? reNewInputPassword}) {
    return 0 == newInputPassword!.compareTo(reNewInputPassword ?? '') ? null : tr('PasswordNotMatchError');
  }

  final _btnSubject = BehaviorSubject<bool>();

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;

  void _validateForm() {
    Rx.combineLatest3(
      _inputUserNameSubject,
      _newInputPasswordSubject,
      _reNewInputPasswordSubject,
      (userName, newPassword, newReInputPassword) {
        return (userName != null && userName != '')  &&
            Validation.isPassValid(newPassword as String?) &&
            _matchNewPassword(newInputPassword: newPassword, reNewInputPassword: newReInputPassword as String?) == null;
      },
    ).listen((enable) {
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  void handleRegisterAccount({
    required String userName,
    required String password,
  }) {
    btnSink.add(false);
    loadingSink.add(true); // show loading

    _signUpRepository.signUp(username: userName, password: password).then(
      (result) async {
        if (result.id != null) {
          await doShowDialog(
            description: tr('success_register_account'),
            typeDialog: DIALOG_CONGRATULATE_BUTTON,
            event: SignUpSuccessEvent(username: userName, password: password),
          );
        } else {
          processEventSink.add(SignUpFailEvent(tr('register_account_error')));
        }
        btnSink.add(true); // Enable Button
        loadingSink.add(false); // hide loading
      },
      onError: (e) {
        btnSink.add(true); // Enable Button
        loadingSink.add(false); // hide loading
        processEventSink.add(SignUpFailEvent(tr('register_account_error')));
      },
    );
  }

  Future<void> doShowDialog({required String description, String? title, String? typeDialog, BaseEvent? event}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title ?? tr('Info'),
      description: description,
      typeDialog: typeDialog ?? DIALOG_ONE_BUTTON,
    );

    if (dialogResult.confirmed) {
      // Check event
      handleEventDialog(event);
    } else {
      // print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent? event) {
    switch (event.runtimeType) {
      case SignUpSuccessEvent:
        final e = event as SignUpSuccessEvent;
        processEventSink.add(SignUpSuccessEvent(username: e.username, password: e.password));
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _inputUserNameSubject.close();
    _newInputPasswordSubject.close();
    _reNewInputPasswordSubject.close();
    _btnSubject.close();
  }
}
