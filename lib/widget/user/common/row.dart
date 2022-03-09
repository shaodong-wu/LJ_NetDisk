import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  /// 背景颜色
  final Color backgroundColor;

  /// 内边距
  final EdgeInsets padding;

  /// 长按事件
  final VoidCallback? onPressed;

  /// 行高
  final double? height;

  // 是否使用分割线
  final bool offstage;

  /// 子Widget
  final List<Widget>? children;

  const CustomRow({
    Key? key,
    this.height,
    this.offstage = true,
    this.children = const [],
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(0),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      Container(
        color: backgroundColor,
        height: height,
        padding: padding,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children!,
          ),
        ),
      ),
    ];
    if (offstage) {
      _list.add(const Divider(
        height: 0,
        thickness: 0.2,
        color: Colors.grey,
      ));
    }

    return Column(
      children: _list,
    );
  }
}
