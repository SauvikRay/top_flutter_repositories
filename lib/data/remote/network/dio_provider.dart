import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'pretty_dio_logger.dart';
import 'request_headers.dart';
import 'retry_interceptor/dio_connectivity_request.dart';
import 'retry_interceptor/retry_interceptor.dart';

class DioProvider {
  static const String baseUrl = "https://api.github.com/"; //Live

  // static const String _appSecret = "AllbXVrdWwtaG9dfsdfsW58MTU5OTgyNzYxMgNews";

  static Dio? _instance;

  static const int _maxLineWidth = 90;
  static final _prettyDioLogger = PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: _maxLineWidth);

  static final BaseOptions _options = BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 60), receiveTimeout: const Duration(seconds: 60),);

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

    static final retryRequest=DioConnectivityRequest(dio:_instance!,connectivity:  Connectivity());
    static final retryInterceptor= OnRetryConnection(request:retryRequest );

  static _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(RequestHeaderInterceptor());
    _instance!.interceptors.add(_prettyDioLogger);
    _instance!.interceptors.add(retryInterceptor);
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


