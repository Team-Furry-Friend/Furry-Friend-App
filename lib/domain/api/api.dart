import 'package:dio/dio.dart';
import 'package:furry_friend/domain/model/basket/basket.dart';
import 'package:furry_friend/domain/model/chat/chat.dart';
import 'package:furry_friend/domain/model/chat/chat_message_page.dart';
import 'package:furry_friend/domain/model/chat/chat_participants.dart';
import 'package:furry_friend/domain/model/post/review.dart';
import 'package:furry_friend/domain/model/user/verify_user.dart';

import '../model/post/page_post.dart';
import '../model/post/post.dart';
import '../model/user/token.dart';
import '../model/user/user.dart';
import 'client.dart';

class ApiRepositories {
  static final Dio _dio = UserClient().dio;

  void setClientRefreshToken(String token) {
    _dio.options.headers["Authorization"] = token;
  }

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

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  dynamic? responseCheck(Map<String, dynamic>? value) {
    if (value != null && value.containsKey("data")) {
      return value["data"];
    }

    return null;
  }

  // 토큰 검증
  Future<VerifyUser> userVerify(header) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyUser>(
            settingOptions('GET', 'gateway/isvalid', headers: header)));
    final value = VerifyUser.fromJson(responseCheck(_result.data)!);
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
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(settingOptions('POST', 'member/join',
            queryParameters: queryParameters)));
    return _result;
  }

  Future<Token> login(username, password) async {
    final body = <String, dynamic>{
      'username': username,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Token>(
            settingOptions('POST', 'member/login', data: body)));
    final value = Token.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<User> socialLogin(social, String kakaoCode) async {
    Map<String, dynamic> queryParameters = {};
    if (kakaoCode.isNotEmpty) {
      queryParameters = <String, dynamic>{
        'code': kakaoCode,
      };
    }
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<User>(
        settingOptions('GET', 'oauth2/$social',
            queryParameters: queryParameters)));
    final value = User.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<Token> userInfoPatch(mid, name, address, phone) async {
    final queryParameters = <String, dynamic>{
      'mid': mid,
      'name': name,
      'address': address,
      'phone': phone,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            Token>(
        settingOptions('PATCH', '/oauth2', queryParameters: queryParameters)));
    final value = Token.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<Token> userRefreshToken(header) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Token>(
            settingOptions('POST', 'member/refresh-token', headers: header)));
    final value = Token.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<PagePost> getPosts(page, size, type, keyword) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'size': size,
      'type': type,
      'keyword': keyword,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
            PagePost>(
        settingOptions('GET', 'products', queryParameters: queryParameters)));
    final value = PagePost.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<Response> postPost(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            settingOptions('POST', 'products', data: options)));
    return _result;
  }

  Future<Response> putPost(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            settingOptions('PATCH', 'products', data: options)));
    return _result;
  }

  Future<Post> getPostDetail(pid) async {
    final queryParameters = <String, dynamic>{
      'pid': pid,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Post>(
        settingOptions('GET', 'products/detail',
            queryParameters: queryParameters)));
    final value = Post.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<List<Post>> getPopularityPost() async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            settingOptions('GET', 'products/popularity')));
    final value = responseCheck(_result.data)!
        .map((dynamic i) => Post.fromJson(i as Map<String, dynamic>))
        .toList();

    return List<Post>.from(value);
  }

  Future<Response> deletePost(pid) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(settingOptions('DELETE', 'products/$pid')));
    return _result;
  }

  // 댓글 API
  Future<List<Review>> getReviews(int pid) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            settingOptions('GET', 'reviews/$pid')));
    final value = responseCheck(_result.data)!
        .map((dynamic i) => Review.fromJson(i as Map<String, dynamic>))
        .toList();

    return List<Review>.from(value);
  }

  Future<Response> postReview(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            settingOptions('POST', 'reviews/', data: options)));
    return _result;
  }

  Future<Response> deleteReview(int rid) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(settingOptions('DELETE', 'reviews/$rid')));
    return _result;
  }

  // 채팅 API
  Future<List<Chat>> getChats() async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(settingOptions('GET', 'chats')));
    final value = responseCheck(_result.data)!
        .map((dynamic i) => Chat.fromJson(i as Map<String, dynamic>))
        .toList();

    return List<Chat>.from(value);
  }

  Future<ChatMessagePage> getMessages(int roomId, time) async {
    final queryParameters = <String, dynamic>{
      'time': time,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(settingOptions(
            'GET', 'chats/$roomId',
            queryParameters: queryParameters)));
    final value = ChatMessagePage.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<ChatParticipants> postChat(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ChatParticipants>(
            settingOptions('POST', 'chats', data: options)));
    final value = ChatParticipants.fromJson(responseCheck(_result.data)!);
    return value;
  }

  Future<Response> deleteChat(int roomId) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(settingOptions('DELETE', 'chats/$roomId')));
    return _result;
  }

  // 찜 목록 API
  Future<List<Basket>> getBaskets() async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(settingOptions('GET', 'baskets')));
    final value = responseCheck(_result.data)!
        .map((dynamic i) => Basket.fromJson(i as Map<String, dynamic>))
        .toList();

    return List<Basket>.from(value);
  }

  Future<List<Basket>> getMyBasketProducts() async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, dynamic>>(
            settingOptions('GET', 'baskets/member')));
    final value = responseCheck(_result.data)!
        .map((dynamic i) => Basket.fromJson(i as Map<String, dynamic>))
        .toList();

    return List<Basket>.from(value);
  }

  Future<Response> postBasket(options) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(
            settingOptions('POST', 'baskets', data: options)));
    return _result;
  }

  Future<Response> deleteBasket(int bid) async {
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Response>(settingOptions('DELETE', 'baskets/$bid')));
    return _result;
  }
}
