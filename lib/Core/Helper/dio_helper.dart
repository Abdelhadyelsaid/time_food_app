import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Const/AppUrl.dart';
import 'cache_helper.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    debugPrint('dio helper run');
    dio = Dio(BaseOptions(
      receiveTimeout: const Duration(seconds: 500),
      validateStatus: (_) => true,
      baseUrl: AppUrls.baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> postData({
    bool isJsonContentType = true,
    Map<String, dynamic>? headers,
    required String url,
    var data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = headers ?? {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "loginToken")}',
    };
    return dio!.post(
      url,
      data: data,
      queryParameters: query,
      options: Options(
        contentType: isJsonContentType
            ? Headers.jsonContentType
            : Headers.formUrlEncodedContentType,
        followRedirects: false,
        // validateStatus: (status) {
        //   return status! < 500;
        // }
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    bool downloadRequest = false,
  }) async {
    dio!.options.headers = headers ??
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
    return await dio!.get(
      url,
      queryParameters: query,
      options: Options(
          followRedirects: false,
          responseType:
              downloadRequest ? ResponseType.bytes : ResponseType.json,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = headers ?? {};
    return await dio!.delete(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  static Future<Response> putData({
    required String url,
    bool isJsonContentType = true,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
    var data,
    String? token,
  }) async {
    dio!.options.headers = headers ?? {};
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          contentType: isJsonContentType
              ? Headers.jsonContentType
              : Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

}
