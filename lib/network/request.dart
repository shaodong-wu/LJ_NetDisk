import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lj_netdisk/config/network_config.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';

class NetWorkRequest {

  /// Dio 请求实例
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: NetWorkConfig.baseUrl,
    connectTimeout: NetWorkConfig.connectTimeout,
    receiveTimeout: NetWorkConfig.receiveTimeout
  ))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
      // 请求截拦
      List<dynamic>? credentials = await LocalStorage.get('credentials');
      if (credentials != null && credentials.isNotEmpty) {
        // 将多个内容凭借为字符串
        String credentialsStr = credentials.map((item) =>
        (item as String).split(';')[0]
        ).join(',');
        // 添加请求头
        options.headers.addAll({
          'Cookie-Credentials': credentialsStr
        });
        debugPrint('[Request] [${options.uri.path}] [Cookie-Credentials]: $credentialsStr');
      }
      handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      // 响应截拦
      List<String>? credentials = response.headers['Set-Cookie-Credentials'];
      if (credentials != null && credentials.isNotEmpty) {
        // 验证码凭证
        if (response.realUri.path == '/api/public/img/getvcode') {
          LocalStorage.save('vcodeVoucher', credentials.first);
        } else {
          LocalStorage.save('credentials', credentials);
        }
        debugPrint('[Response] [${response.realUri.path}] [Set-Cookie-Credentials]: ${credentials.toString()}');
      }
      handler.next(response);
    },
    onError: (err, handle) {
      // 错误截拦
      handle.next(err);
    },
  ));


  /// 发起网络请求
  static Future<Map<String, dynamic>> request({
    /// 请求的URL
    required String url,

    /// 请求的方法
    required String method,

    /// Body 携带数据
    dynamic data,

    /// 请求的参数(请求时携带的参数)  JSON
    Map<String, dynamic>? params,

    /// 可选参数 (可以设置请求头)
    Map<String, dynamic>? header,

    /// 截拦器 (使用默认截拦器)
    Interceptor? inter,
  }) async {
    // 1.请求的单独配置
    Options options = Options(
      method: method,
      headers: header
    );

    // 2.添加拦截器
    if (inter != null) {
      _dio.interceptors.add(inter);
    }

    // 3.忽略 HTTPS 证书异常
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.badCertificateCallback=(cert, host, port){
        return true;
      };
    };

    // 4.发送网络请求
    Response response = await _dio.request(
      url,
      data: data,
      queryParameters: params,
      options: options,
    );
    return json.decode(response.data);
  }

  // 文件下载
  // url 下载的地址
  // progressCallback 下载进度变化时的回调，用来实现进度条
  // Future<Response> dioDownload(String url, progressCallback) async {
  //   CancelToken cancelToken = CancelToken();//可以用来取消操作
  //   String docPath = await Application.fileUtil.getDocPath();//获取document目录
  //   String file = docPath + '/' + Application.util.guid() + extension(url);//本地文件名
  //   Response response = await _dio.download(url, file,
  //       onReceiveProgress: progressCallback == null
  //           ? null
  //           : (int count, int total) {
  //         if (total == -1) {
  //           //不知道进度的默认50%
  //           total = count * 2;
  //         }
  //         progressCallback(count, total, cancelToken);
  //       },
  //       cancelToken: cancelToken);
  //   response.extra = <String, dynamic>{"localPath": file};
  //   return response;
  // }

  // 文件上传
  // url - 上传的地址
  // filePath - 本地文件路径
  // progressCallback - 上传进度变化时的回调，用来实现进度条
  static Future<Map<String, dynamic>> uploadFile({
    required String url,
    required String filePath,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    required Function? progressCallback
  }) async {
    // 忽略 HTTPS 证书异常
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.badCertificateCallback=(cert, host, port){
        return true;
      };
    };

    Map<String, dynamic> data = Map.of(body ?? {});
    data['files'] = await MultipartFile.fromFile(filePath);
    FormData formData = FormData.fromMap(data);   //  form data上传文件
    CancelToken cancelToken = CancelToken();
    Response response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headers),
        onSendProgress: (int count, int data) {
          if (progressCallback != null) {
            progressCallback(count, data, cancelToken);
          }
        }
    );
    return json.decode(response.data);
  }
}