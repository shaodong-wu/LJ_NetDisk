import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/views/common/web_view.dart';

import 'package:lj_netdisk/config/router_config.dart';

/// app 协议头
const String appScheme = "ljnetdisk://";

class ProjectRouter {
  /// 执行页面跳转
  ///
  /// 需要特别注意以下逻辑
  /// -1 不在首页，则执行跳转
  /// 大于 -1 则为首页，需要在首页进行 tab 切换，而不是进行跳转
  int open(BuildContext context, String url) {
    // 非entrance入口标识
    int notEntrancePageIndex = -1;

    if (url.startsWith(appScheme)) {
      url = url.substring(appScheme.length);
    }

    // 打开 WebViewPage
    if (url.startsWith('https://') || url.startsWith('http://')) {
      // 打开网页
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WebViewPage(url: url);
      }));
      return notEntrancePageIndex;
    }

    Map<String, dynamic> urlParseRet = _parseUrl(url);

    if (RouterConfig.routerMapping[urlParseRet['action']] != null) {
      int entranceIndex = RouterConfig.routerMapping[urlParseRet['action']]!.entranceIndex;
      if (entranceIndex > notEntrancePageIndex) {
        // 判断为首页，返回切换的tab信息
        return entranceIndex;
      }
    }

    Navigator.pushNamedAndRemoveUntil(context, urlParseRet['action'].toString(), (route) {
      if (route.settings.name == urlParseRet['action'].toString()) {
        return false;
      }
      return true;
    }, arguments: urlParseRet['params']);
    // 执行跳转，非首页
    return notEntrancePageIndex;
  }

  /// 解析跳转的url，并且分析其内部参数
  Map<String, dynamic> _parseUrl(String url) {

    int placeIndex = url.indexOf('?');

    if (url.isEmpty) {
      return {'action': '/', 'params': null};
    }
    if (placeIndex < 0) {
      return {'action': url, 'params': null};
    }

    String action = url.substring(0, placeIndex);
    String paramStr = url.substring(placeIndex + 1);

    if (paramStr.isEmpty) {
      return {'action': action, 'params': null};
    }

    Map params = {};
    List<String> paramsStrArr = paramStr.split('&');
    for (String singleParamsStr in paramsStrArr) {
      List<String> singleParamsArr = singleParamsStr.split('=');
      // 获取组件参数
      if (RouterConfig.routerMapping[action] !=null && RouterConfig.routerMapping[action]!.params != null) {
        List<String>? paramsList = RouterConfig.routerMapping[action]!.params;
        if (paramsList != null && paramsList.contains(singleParamsArr[0])) {
          params[singleParamsArr[0]] = singleParamsArr[1];
        }
      }
    }
    return {'action': action, 'params': params};
  }

  /// 注册路由事件
  Map<String, Widget Function(BuildContext)> registerRouter() {
    Map<String, Widget Function(BuildContext)> routerInfo = {};

    RouterConfig.routerMapping.forEach((routerName, routerData) {
      if (routerName.toString() == '/') {
        // 默认逻辑不处理
        return;
      }
      routerInfo[routerName.toString()] = (context) => routerData.widget;
    });
    return routerInfo;
  }

  /// 根据页面名字，获取页面 [Widget]
  Widget getPageByRouter(String routeName) {
    Widget pageWidget;
    if (RouterConfig.routerMapping[routeName] != null && RouterConfig.routerMapping[routeName]!.widget != null) {
      pageWidget = RouterConfig.routerMapping[routeName]!.widget;
    } else {
      pageWidget = RouterConfig.routerMapping['/']!.widget;
    }
    return pageWidget;
  }

}