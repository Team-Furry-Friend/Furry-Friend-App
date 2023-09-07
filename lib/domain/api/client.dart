import 'package:dio/dio.dart';
import 'package:furry_friend/common/prefs_utils.dart';

class UserClient {
  Dio dio = Dio();

  UserClient() {
    BaseOptions _options = BaseOptions(
      baseUrl: 'https://howstheairtoday.site/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    );

    dio = Dio(_options);
    dio.options.headers["Authorization"] =
        PrefsUtils.getString(PrefsUtils.utils.refreshToken);
    dio.interceptors.add(QueuedInterceptorsWrapper(onError: (e, handler) {
      return handler.reject(e);
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
