import 'package:dio/dio.dart';

import '../model/post/page_post.dart';
import '../model/post/post.dart';
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
  Future<Response> join(email, mpw, name, address, phone) async {
    final queryParameters = <String, dynamic>{
      'email': email,
      'mpw': mpw,
      'name': name,
      'address': address,
      'phone': phone,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
        'POST', 'member/join',
        queryParameters: queryParameters));
    return _result;
  }

  Future<Token> login(username, password) async {
    final queryParameters = <String, dynamic>{
      'username': username,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
        'POST', 'member/login',
        queryParameters: queryParameters));
    final value = Token.fromJson(_result.data!);
    return value;
  }

  Future<User> socialLogin(social) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(settingOptions(
      'GET',
      'oauth2/$social',
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

  Future<PagePost> getPosts(page, size, type, keyword) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'size': size,
      'type': type,
      'keyword': keyword,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('GET', 'products', queryParameters: queryParameters));
    final value = PagePost.fromJson(_result.data!);
    return value;
  }

  Future<Response> postPost(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('POST', 'products', data: options));
    return _result;
  }

  Future<Response> putPost(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('PUT', 'products', data: options));
    return _result;
  }

  Future<Post> getPostDetail(pid) async {
    final _result = await _dio
        .fetch<Map<String, dynamic>>(settingOptions('GET', 'products/$pid'));
    final value = Post.fromJson(_result.data!);
    return value;
  }

  Future<Post> getPopularityPost() async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        settingOptions('GET', 'products/popularity'));
    final value = Post.fromJson(_result.data!);
    return value;
  }

  Future<Response> deletePost(pid) async {
    final _result = await _dio
        .fetch<Map<String, dynamic>>(settingOptions('DELETE', 'products/$pid'));
    return _result;
  }
}
