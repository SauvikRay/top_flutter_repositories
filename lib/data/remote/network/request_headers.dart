import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';


class RequestHeaderInterceptor extends InterceptorsWrapper {
  final _storage = GetStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final String accessToken = _storage.read("") ?? "";
    var customHeaders = {'content-type': 'application/json'};
    if (accessToken.trim().isNotEmpty) {
      customHeaders.addAll({
        'Authorization': "Bearer $accessToken",
      });
    }
    return customHeaders;
  }
}
