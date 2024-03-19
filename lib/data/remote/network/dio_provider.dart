import 'package:dio/dio.dart';

import 'pretty_dio_logger.dart';
import 'request_headers.dart';

class DioProvider {
  // static const String baseUrl = "https://dev.perfectedgetech.com/all-dev-projects/allnews-dev/";
  static const String baseUrl = "https://allnews.ng/"; //Live

  static const String _appSecret = "AllbXVrdWwtaG9zZW58MTU5OTgyNzYxMgNews";

  static Dio? _instance;

  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: _maxLineWidth);

  static final BaseOptions _options = BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 60), receiveTimeout: const Duration(seconds: 60), headers: {"app-secret": _appSecret});

  static Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);

      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      _instance!.interceptors.add(_prettyDioLogger);

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  static Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  static Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(RequestHeaderInterceptor());
    _instance!.interceptors.add(_prettyDioLogger);
  }

  static String _buildContentType(String version) {
    return "user_defined_content_type+$version";
  }

  DioProvider.setContentType(String version) {
    _instance?.options.contentType = _buildContentType(version);
  }

  DioProvider.setContentTypeApplicationJson() {
    _instance?.options.contentType = "application/json";
  }
}

//Network Constants

class NetworkConstants {
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "en";
  static const APP_KEY_VALUE = "dfsdfAWSDASDCdsfsdfASDAS";
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}
