import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:interview_project/data/service/login_service/login_service.dart';
import 'package:interview_project/common/define_field.dart';

class LoginRepository {
  LoginRepository({required LoginService loginService}) : _loginService = loginService;

  final LoginService _loginService;

  Future<String> login({required String username, required String password}) async {
    final c = Completer<String>();
    try {
      final response = await _loginService.loginService(username: username, password: password);
      final token = response.data[TOKEN_FIELD];
      c.complete(token);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        c.completeError(tr('connectTimeout'));
      }
      c.completeError(e.toString());
    } catch (ex) {
      c.completeError(ex.toString());
    }
    return c.future;
  }
}
