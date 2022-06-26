import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:psgames/config/api_config.dart';

class HttpService {
  Dio? _dio;

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: APIConfig.base_url));

    initializeInterceptors();
  }

  ////////////////////// Dio Get Request..............

  Future<Response?> getRequest(String endPoint, {String? query}) async {
    Response? response;

    try {
      response = await _dio!.get(
        (query != null && query.isNotEmpty)
            ? APIConfig.base_url +
                endPoint +
                '?key=' +
                APIConfig.api_key +
                '&' +
                query
            : APIConfig.base_url + endPoint + '?key=' + APIConfig.api_key,
      );
    } on DioError catch (e) {
      print(e);
    } on Exception catch (e) {
      print('error : $e');
    }

    int? statusCode = response?.statusCode;

    if (statusCode! >= 400) {
      return null;
    } else if (response?.data != null) {
      return response;
    } else {
      return null;
    }
  }

////////////////// Init Interceptors ...................
  initializeInterceptors() {
    _dio!.interceptors.add(InterceptorsWrapper(onError: (error, errorHandler) {
      print('error - ${error.message}');
      errorHandler.next(error);
    }, onRequest: (request, requestHandler) {
      print('path - ${request.path}');
      requestHandler.next(request);
    }, onResponse: (response, responseHandler) {
      print('data - ${response.data}');
      responseHandler.next(response);
    }));
  }
}
