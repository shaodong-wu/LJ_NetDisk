import 'package:flutter/material.dart';

/// router 配置数据结构
class StructRouter {
  /// 组件
  final Widget widget;

  /// 首页入口index
  final int entranceIndex;

  /// 组件参数列表
  final List<String>? params;

  /// 是否 TabPage
  final bool isTabPage;

  /// 默认构造函数
  const StructRouter(
    this.widget,
    this.entranceIndex,
    this.params,
    this.isTabPage
  );
}
