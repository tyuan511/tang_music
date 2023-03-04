import 'package:dio/dio.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/storage.dart';

class _DioFactory {
  const _DioFactory(this._baseUrl);

  final String _baseUrl;

  Dio create() => Dio(BaseOptions(
        baseUrl: _baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 5),
      ))
        ..interceptors.add(_DefaultInterceptor());
}

class _DefaultInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? configBaseUrl = Storage.local.getString(ConfigKeys.apiBaseUrlKey);
    if (configBaseUrl != null) {
      options.baseUrl = configBaseUrl;
    }

    String? cookie = Storage.local.getString(ConfigKeys.cookieKey) ?? '';
    options.headers["cookie"] = cookie;
    options.queryParameters['cookie'] = cookie;
    handler.next(options);
  }
}

final httpClient = const _DioFactory('https://netease.yt7.one').create();
