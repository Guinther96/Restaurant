import 'package:dio/dio.dart';
import 'package:table_ordering_client/core/constants/app_constants.dart';
import 'package:table_ordering_client/core/errors/app_exception.dart';

class ApiClient {
  ApiClient() : dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl)) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              error: mapDioException(error),
              type: error.type,
            ),
          );
        },
      ),
    );
  }

  final Dio dio;
}
