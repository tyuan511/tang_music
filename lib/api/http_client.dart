import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tang_music/consts.dart';
import 'package:tang_music/services/config_service.dart';

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
  final _configService = Get.find<ConfigService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? configBaseUrl = _configService.pref.getString(ConfigKeys.apiBaseUrlKey);
    if (configBaseUrl != null) {
      options.baseUrl = configBaseUrl;
    }

    String? cookie = _configService.pref.getString(ConfigKeys.cookieKey) ?? '';
    options.headers["cookie"] = cookie;
    options.queryParameters['cookie'] = cookie;
    handler.next(options);
  }
}

final httpClient = const _DioFactory(apiBaseUrl).create();
