import 'package:dio/dio.dart';
import 'package:logger/web.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  //error logger
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d(
      'Error type: ${err.error} \n'
      'Error message: ${err.message}',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');
    if (options.data != null) {
      logger.d('Request data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('Status code: ${response.statusCode} \n'
        'Staus message: ${response.data} \n'
        'Response header: ${response.headers} \n'
        'Response data: ${response.data}');
    handler.next(response);
  }
}
