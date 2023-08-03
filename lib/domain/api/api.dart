import 'package:dio/dio.dart';

import '../model/user/token.dart';
import '../model/user/user.dart';
import 'client.dart';


class ApiRepositories {
  static final Dio _dio = UserClient().dio;

  RequestOptions settingOptions(String method, String path,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? extra,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      int? receiveTimeout}) {
    Map<String, dynamic> _extra = extra ?? {};
    final Map<String, dynamic> _queryParameters = queryParameters ?? {};
    final Map<String, dynamic> _headers = headers ?? {};
    final Map<String, dynamic> _data = data ?? {};

    try {
      throw "get StackTrace";
    } catch (e, s) {
      List<String> stackTrace = s.toString().split("\n");
      if (stackTrace.length >= 2) {
        String apiName = stackTrace[1].split(" (").first.split(".").last;
        _extra.addAll({"name": "${apiName.trim()}"});
      }
    }

    return Options(
            method: method,
            headers: _headers,
            extra: _extra,
            receiveTimeout: _dio.options.receiveTimeout)
        .compose(_dio.options, path,
            queryParameters: _queryParameters, data: _data)
        .copyWith(baseUrl: _dio.options.baseUrl);
  }

  // 토큰 검증
  Future<User> userVerify(header) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('GET', 'gateway/isvalid', headers: header));
    final value = User.fromJson(_result.data!);
    return value;
  }

  // 회원 API
  Future<Response> login(email, mpw, name, address, phone) async {
    final queryParameters = <String, dynamic>{
      'email': email,
      'mpw': mpw,
      'name': name,
      'address': address,
      'phone': phone,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
        'POST', 'member/login',
        queryParameters: queryParameters));
    return _result;
  }

  Future<Token> join(username, password) async {
    final queryParameters = <String, dynamic>{
      'username': username,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
        'POST', 'member/join',
        queryParameters: queryParameters));
    final value = Token.fromJson(_result.data!);
    return value;
  }

  Future<User> socialLogin(social) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
      'GET',
      '/oauth2/$social',
    ));
    final value = User.fromJson(_result.data!);
    return value;
  }

  Future<Token> userInfoPatch(mid, name, address, phone) async {
    final queryParameters = <String, dynamic>{
      'mid': mid,
      'name': name,
      'address': address,
      'phone': phone,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('PUT', '/oauth2', queryParameters: queryParameters));
    final value = Token.fromJson(_result.data!);
    return value;
  }

  Future<Token> userRefreshToken(header) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('POST', 'member/refresh-token', headers: header));
    final value = Token.fromJson(_result.data!);
    return value;
  }
}
