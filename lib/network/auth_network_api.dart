import 'package:dio/dio.dart';
import 'package:interview_project/common/common.dart';
import 'package:interview_project/common/define_service_api.dart';
import 'package:interview_project/data/shared_preferences/shared_preferences.dart';
import 'package:interview_project/shared_code/utils/materials/constant.dart';

class AuthServiceNetwork {
  AuthServiceNetwork._internal() {
    // Add Header for Request Token
    _dio.interceptors.add(
      InterceptorsWrapper(onRequest: (myOption, handler) async {
        final token = await SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN);
        if (token != null && token.toString().isNotEmpty) {
          myOption.headers['Authorization'] = 'Bearer $token';
        }

        myOption.contentType = 'application/json';
        // Get language of App
        final language = await SPref.instance.get(SPrefCache.LANGUAGE_APP);
        if (language == null || language.toString().isEmpty) {
          myOption.headers['Accept-Language'] = 'vi-VN';
          return handler.next(myOption); //continue
        }

        final acceptLanguage = language == VIETNAMESE_LANGUAGE ? 'vi-VN' : 'en-US';
        myOption.headers['Accept-Language'] = acceptLanguage;

        return handler.next(myOption); //continue
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (err, handler) async {
        return handler.next(err);
      }),
    );
  }

  static BaseOptions options = BaseOptions(
    baseUrl: graphQLAuthUrl,
    connectTimeout: CONNECT_TIMEOUT,
    receiveTimeout: RECEIVE_TIMEOUT,
  );
  static final Dio _dio = Dio(options);

  static final AuthServiceNetwork instance = AuthServiceNetwork._internal();

  Dio get dio => _dio;
}
