/// 封装的一个可以加载本地和网络文件的WebViewPage
///
/// @Date 2021-12-01
/// @Author xiangzhihong
/// @Org https://zhuanlan.zhihu.com/p/158682432

import 'dart:convert' show Encoding;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String url;
  final String? title;
  final bool isLocalUrl;

  WebViewController? _webViewController;

  WebViewPage({
    Key? key,
    required this.url,
    this.isLocalUrl = false,
    this.title,
  }) : super(key: key);

  @override
  _WebViewPage createState() => _WebViewPage();
}

class _WebViewPage extends State<WebViewPage> {

  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'jsbridge', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage message) async{
        debugPrint(message.message);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppbar(),
        body: _buildBody()
    );
  }

  _buildAppbar() {
    return AppBar(
        elevation: 0,
        backgroundColor: const Color(0x00ccd0d7),
        title: Text(widget.title ?? widget.url, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(50, 50, 50, 1)),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        )
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 1,
          width: double.infinity,
          child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.isLocalUrl ? Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
                .toString(): widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>{
              jsBridge(context)
            },
            onWebViewCreated: (WebViewController controller){
              widget._webViewController = controller;
              if(widget.isLocalUrl){
                _loadHtmlAssets(controller);
              }else{
                controller.loadUrl(widget.url);
              }
              controller.canGoBack().then((value) => debugPrint(value.toString()));
              controller.canGoForward().then((value) => debugPrint(value.toString()));
              controller.currentUrl().then((value) => debugPrint(value));
            },
            onPageFinished: (String value){
              if (widget._webViewController != null) {
                widget._webViewController!.runJavascriptReturningResult('document.title')
                    .then((title) => debugPrint(title));
              }
            },
          ),
        )
      ],
    );
  }

//加载本地文件
  _loadHtmlAssets(WebViewController controller) async {
    String htmlPath = await rootBundle.loadString(widget.url);
    controller.loadUrl(Uri.dataFromString(htmlPath, mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}