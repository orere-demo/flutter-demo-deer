import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:demo2_deer/res/constant.dart';
import 'package:demo2_deer/net/base_entity.dart';
import 'error_handle.dart';

// 默认配置
int _connectTimeout = 15000;
int _receiveTimeout = 15000;
int _sendTimeout = 10000;
String _baseUrl = '';
List<Interceptor> _interceptors = [];

// 初始化配置
void configDio({
  int? coonectTimeout,
  int? receiveTimeout,
  int? sendTimeout,
  String? baseUrl,
  List<Interceptor>? interceptors,
}) {
  _connectTimeout = coonectTimeout ?? _connectTimeout;
  _receiveTimeout = receiveTimeout ?? _receiveTimeout;
  _sendTimeout = sendTimeout ?? _sendTimeout;
  _baseUrl = baseUrl ?? _baseUrl;
  _interceptors = interceptors ?? _interceptors;
}

typedef NetSuccessCallback<T> = Function(T data);

// 当你需要构造函数不是每次都创建一个新的对象时，使用factory关键字。
class DioUtils {
  factory DioUtils() => _singleton;

  DioUtils._() {
    print('DioUtils._()');
    final BaseOptions _options = BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
      sendTimeout: _sendTimeout,

      /// dio默认json解析，这里指定返回UTF8字符串，自己处理解析。（可也以自定义Transformer实现）
      responseType: ResponseType.plain,
      validateStatus: (_) {
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: _baseUrl,
      // contentType: Headers.formUrlEncodedContentType, // 适用于post form表单提交
    );

    _dio = Dio(_options);

    /// 添加拦截器
    _interceptors.forEach((interceptor) {
      _dio.interceptors.add(interceptor);
    });
  }

  static final DioUtils _singleton = DioUtils._();

  static DioUtils get instance => DioUtils();

  static late Dio _dio;

  Dio get dio => _dio;

  Future<BaseEntity<T>> _request<T>(String method, String url,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      Options? options}) async {
    final Response<String> response = await _dio.request<String>(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    try {
      final String data = response.data.toString();
      // final bool isCompute = !Constant.isDriverTest && data.length > 10 * 1024;
      final bool isCompute = data.length > 10 * 1024;
      final Map<String, dynamic> _map =
          isCompute ? await compute(parseData, data) : parseData(data);
      return BaseEntity.formJson(_map);
    } catch (e) {
      return BaseEntity<T>(ExceptionHandle.parse_error, '数据解析错误', null);
    }
  }

  Options _checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }
}

Map<String, dynamic> parseData(String data) {
  return json.decode(data) as Map<String, dynamic>;
}
