import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:interview_project/data/service/sign_up_service/sign_up_service.dart';
import 'package:interview_project/shared_code/model/sign_up_model/response_sign_up_model.dart';

class SignUpRepository {
  SignUpRepository({required SignUpService signUpService}) : _signUpService = signUpService;

  final SignUpService _signUpService;

  Future<ResponseSignUpModel> signUp({required String username, required String password}) async {
    final c = Completer<ResponseSignUpModel>();
    try {
      final response = await _signUpService.signUpService(username: username, password: password);
      final result = ResponseSignUpModel.fromJson(response.data);
      c.complete(result);
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
