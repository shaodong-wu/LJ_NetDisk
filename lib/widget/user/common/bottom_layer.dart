import 'package:flutter/material.dart';
import 'package:lj_netdisk/widget/user/common/title.dart';

class CustomBottom {
  static Future<T?> bottomDialog<T>({
    required BuildContext context,

    /// 是否显示默认标题
    bool isShowTitle = true,
    List<Widget> children = const [],

    /// 背景颜色
    Color backgroundColor = Colors.white,

    /// 标题
    String title = "",
    bool isScrollControlled = true,

    /// 高度
    double? height = 430,

    /// 确定
    VoidCallback? onOk,

    /// 取消
    VoidCallback? onCancel,
  }) {
    onOk ??= () => Navigator.pop(context);
    onCancel ??= onOk;

    List<Widget> _list = [];
    if (isShowTitle) {
      _list.add(CustomTitle(
        title: title,
        fallback: onCancel,
        actions: [
          TextButton(
            onPressed: onOk,
            child: const Text("完成"),
          )
        ],
      ));
    }
    _list.addAll(children);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: backgroundColor,
            ),
            height: height,
            child: ListView(
              children: _list,
            ),
          ),
        );
      },
    );
  }
}
