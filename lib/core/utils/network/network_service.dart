import 'package:dio/dio.dart';
import '../../constants/api_endpoint.dart';
import '../../constants/typedef.dart';

enum RequestMethod { get, post, put, delete }

extension MethodExtension on RequestMethod {
  String get name {
    switch (this) {
      case RequestMethod.get:
        return 'GET';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.put:
        return 'PUT';
      case RequestMethod.delete:
        return 'DELETE';
    }
  }
}

abstract class NetworkService {
  Future<dioRes> request({
    required String endpoint,
    required RequestMethod method, // 'GET', 'POST', 'PUT', 'DELETE'
    String? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
}

class NetworkServiceDio implements NetworkService {
  final Dio dio;
  NetworkServiceDio()
      : dio = Dio(BaseOptions(
          // baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 8),
          receiveTimeout: const Duration(seconds: 8),
          sendTimeout: const Duration(seconds: 8),
          headers: {
            'Content-Type': 'text/xml; charset=utf-8',
            "User-Agent": "MyTaxiApp/1.0 (tareq4534@gmail.com)"
          },
        ));

  @override
  Future<dioRes> request({
    required String endpoint,
    required RequestMethod method, // 'GET', 'POST', 'PUT', 'DELETE'
    String? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final response = await dio.request(
      endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method.name,
        headers: headers,
      ),
    );
    return response;
  }
}
