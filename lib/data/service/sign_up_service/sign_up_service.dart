import 'package:dio/dio.dart';
import 'package:interview_project/common/define_field.dart';
import 'package:interview_project/common/define_service_api.dart';
import 'package:interview_project/network/auth_network_api.dart';

class SignUpService {
  Future<Response> signUpService({required String username, required String password}) async {
    print('Request SignUp with API: URI: ${AuthServiceNetwork.options.baseUrl}$URN_API_SIGN_UP');
    return AuthServiceNetwork.instance.dio.post(
      URN_API_SIGN_UP,
      data: {
        USERNAME_FIELD: username,
        PASSWORD_FIELD: password,
      },
    );
  }
}
