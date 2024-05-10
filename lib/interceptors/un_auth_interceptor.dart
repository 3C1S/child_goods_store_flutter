import 'dart:io';
import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/configs/configs.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class UnAuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 기타 헤더 작성
    options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

    // time-out 설정
    options.receiveTimeout = const Duration(seconds: 5);

    // base url 설정
    options.baseUrl = Configs.instance.baseUrl;

    // Logging
    debugPrint(
      '[REQ] [${options.method}] ${options.uri}',
    );

    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    // Logging
    debugPrint(
      '[RES / ${response.statusCode}] [${response.requestOptions.method}] ${response.requestOptions.uri}',
    );

    handler.next(response);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Logging
    debugPrint(
      '[ERR / ${err.response?.statusCode}] [${err.requestOptions.method}] ${err.requestOptions.uri}',
    );

    // Error handling
    var httpResCode = err.response?.statusCode;

    // jwt token error
    if (httpResCode == 500 || httpResCode == 401) {
      AuthBlocSingleton.bloc.add(AuthSignout());
    }

    var res = ResModel.fromJson(err.response?.data, (json) => null);
    handler.reject(
      DioException.connectionError(
        requestOptions: err.requestOptions,
        reason: res.message ?? Strings.unknownFail,
        error: res.copyWith(
          code: res.code == -1 ? 5000 : res.code,
          message: res.message ?? Strings.unknownFail,
        ),
      ),
    );
  }
}
