# 浪尖网盘

---

> Api 文档：https://docs.apipost.cn/preview/9935159a2f4504e2/7a3575dd42dba43f

## 项目说明 💻

- 项目名称：浪尖网盘
- 项目简介：基于 Flutter 跨平台框架开发的网盘类移动端APP，实现用户文件的上传预览等基本功能
- 技术栈：Flutter、Dart、Dio、Provider、ApiPost
- 技术描述：
  1. 通过扒取百度网盘的静态资源，为项目UI 界面提高素材
  2. 采用 ApiPost 接口调试工具查看接口返回数据结构，并编写相对应的接口文档
  3. 通过配置URL Scheme实现外部对 APP 呼起，并跳转到相对应页面
  4. 通过重写原有的部分 Widget 源码，实现项目自定义主题 UI 样式，以及解决HTTPS三次握手失败、携带用户凭证的问题



## 项目结构 🌲

```css
lj_netdisk
├── README.md                                    // 项目文档
├── analysis_options.yaml
├── android
├── build
├── ios
├── lib                                          // 核心代码
│   ├── assets                                   // 静态资源
│   ├── common                                   // 公共数据
│   ├── config                                   // 全局配置
│   ├── generated_plugin_registrant.dart
│   ├── main.dart                                // 启动文件
│   ├── models                                   // 结构模型
│   ├── network                                  // 网络请求
│   ├── project_router.dart                      // 项目路由
│   ├── styles                                   // 全局样式
│   ├── utils                                    // 工具类
│   ├── views                                    // 页面视图
│   └── widget                                   // Widget
├── lj_netdisk.iml
├── pubspec.lock
├── pubspec.yaml                                 // 相关依赖、配置
├── test
└── web
```





## 问题记录 🤔

### 1.  请求图片携带用户凭证、忽略证书问题

新建`NetworkImageSSL` 工具类：

```dart
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui show instantiateImageCodec, Codec;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

/// Image.network方法显示HTTPS图片时忽略证书
class NetworkImageSSL extends ImageProvider<NetworkImageSSL> {

  const NetworkImageSSL(this.url, {
    this.scale = 1.0,
    required this.headers,
    this.callback
  });

  final String url;

  final double scale;

  final Map<String, String> headers;

  final VoidCallback? callback;

  @override
  Future<NetworkImageSSL> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageSSL>(this);
  }

  @override
  ImageStreamCompleter load(NetworkImageSSL key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(codec: _loadAsync(key), scale: key.scale);
  }

  static final HttpClient _httpClient = HttpClient()
    ..badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);

  Future<ui.Codec> _loadAsync(NetworkImageSSL key) async {
    assert(key == this);

    final Uri resolved = Uri.base.resolve(key.url);
    final HttpClientRequest request = await _httpClient.getUrl(resolved);
    headers.forEach((String name, String value) {
      request.headers.add(name, value);
    });
    final HttpClientResponse response = await request.close();

    if (response.statusCode != HttpStatus.ok) {
      throw Exception(
          'HTTP请求失败，状态码: ${response.statusCode}, $resolved');
    }

    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    if (bytes.lengthInBytes == 0) {
      throw Exception('NetworkImageSSL是一个空文件: $resolved');
    }

    // 成功则执行
    if (callback != null) callback!();

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final NetworkImageSSL typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}

```

使用：

```dart
Image(
  image: NetworkImageSSL(
    widget.imageUrl,      // 图片地址
    headers: headers,     // 携带用户凭证
    callback: () {
      ....
    }
  ),
);
```



### 2. 文件上传，并显示进度条

```dart
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
      handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      // 响应截拦
      handler.next(response);
    },
    onError: (err, handle) {
      // 错误截拦
      handle.next(err);
    },
  ));


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
```





## 效果演示 🔥

![APP 启动页](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309134513123.webp)

<p style="font-size: 12px; text-align: center;">App 启动页(一)</p>



![用户登录页](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309134827472.webp)

<p style="font-size: 12px; text-align: center;">App 登录页(二)</p>



![APP 首页](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309135042463.webp)

<p style="font-size: 12px; text-align: center;">App 首页(三)</p>



![上传图片](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309165809365.webp)

<p style="font-size: 12px; text-align: center;">App 文件上传(四)</p>



![图片预览](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309165906151.webp)

<p style="font-size: 12px; text-align: center;">App 图片预览(五)</p>



![搜索文件](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309165952373.webp)

<p style="font-size: 12px; text-align: center;">App 文件搜索(六)</p>



![个人中心](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309170043073.webp)

<p style="font-size: 12px; text-align: center;">App 个人中心(七)</p>



![修改中心](https://gitee.com/shaodong-wu/blog-image/raw/master/2022-03-09/image-20220309170138514.webp)

<p style="font-size: 12px; text-align: center;">App 修改中心(八)</p>





##  免责声明 👊

本项目的所有图片资源、UI 设计以及软件仅用于个人学习开发测试，所有 `百度网盘` `百度` 相关字样版权属于 `北京百度网讯科技有限公司`，勿用于商业及非法用途，如产生法律纠纷与本人无关。

**如此项目造成侵权损失，请联系本人删除：[2361954836@qq.com](mailto:2361954836@qq.com)**