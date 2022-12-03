import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

class BaseDioClient {
  final String? baseUrl;
  Dio? dioInstance;

  final List<Interceptor>? interceptors;

  BaseDioClient({
    this.baseUrl,
    Dio? dio,
    this.interceptors,
  }) {
    dioInstance = dio ?? Dio();

    (dioInstance!.httpClientAdapter as DefaultHttpClientAdapter)
        .onHttpClientCreate = (client) {
      HttpClient httpClient = HttpClient();

      return httpClient;
    };
  }
}