import 'package:dio/dio.dart';
import 'package:price_tracker/core/services/base_dio_client.dart';

class DioClient extends BaseDioClient {
  DioClient(
    String? baseUrl,
    Dio? dioInstance,
    List<Interceptor>? interceptors,
  ) : super(
          baseUrl: baseUrl,
          dio: dioInstance,
          interceptors: interceptors,
        );
}
