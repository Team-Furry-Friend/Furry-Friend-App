import 'package:dio/dio.dart';

class UserClient {
  static final UserClient _instance = UserClient._internal();

  factory UserClient() => _instance;

  Dio dio = Dio();

  UserClient._internal() {
    BaseOptions _options = BaseOptions(
      baseUrl: 'https://howstheairtoday.site/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    dio = Dio(_options);
    dio.interceptors.add(QueuedInterceptorsWrapper(onError: (e, handler) {
      if (e.response?.statusCode == 401) {}
    }, onResponse: (Response response, handler) {
      if (response.data.toString().contains('error')) {
        return handler.reject(DioException(
            requestOptions: response.requestOptions,
            response: response,
            error: response.data));
      }

      handler.next(response);
    }));
  }
}
