import 'package:dio/dio.dart';
import 'package:interview_project/common/define_field.dart';
import 'package:interview_project/common/define_service_api.dart';
import 'package:interview_project/network/auth_network_api.dart';

class LoginService {
  Future<Response> loginService({required String username, required String password}) async {
    print('Request Login with API: URI: ${AuthServiceNetwork.options.baseUrl}$URN_API_LOGIN');
    return AuthServiceNetwork.instance.dio.post(
      URN_API_LOGIN,
      data: {
        USERNAME_FIELD: username,
        PASSWORD_FIELD: password,
      },
    );
  }
}
