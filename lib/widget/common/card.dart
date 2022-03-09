import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  const CustomCard({
    Key? key,
    this.title,
    this.titleStyle,
    this.leading,
    this.actions,
    required this.body,
    this.padding,
    this.useUnderline = false,
    this.underlineColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget leading = this.leading ?? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // left Widget
        Column(
          children: [
            if(title != null) Text(title!, style: titleStyle ?? const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            )),
            if (useUnderline) Container(
              width: 25,
              height: 3,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  color: underlineColor ?? Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(3.0))
              ),
            )
          ],
        ),

        // Right Widget
        if (actions != null) actions as Widget
      ],
    );

    final Widget body = this.body;

    return Container(
      width: double.maxFinite,
      padding: padding ?? const EdgeInsets.only(top: 18.0, bottom: 18.0, left: 15.0, right: 15.0),
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      child: Column(children: [leading, body]),
    );
  }

  /// 如果 [leading] 为空, [title] 不能为 Null
  /// 内部实现默认 [leading] Widget
  final String? title;

  /// 标题文本样式
  final TextStyle? titleStyle;

  /// 如果 [title] 为空, [leading] 不能为 Null
  /// [leading] 为自定义左侧 [Widget]
  final Widget? leading;

  /// 卡片头部右侧的 Widget
  final Widget? actions;

  /// 卡片主体显示的 Widget
  final Widget body;

  /// 填充内部边距
  final EdgeInsetsGeometry? padding;

  /// Card 背景颜色
  final Color? backgroundColor;

  /// 下划线颜色
  final Color? underlineColor;

  /// 当使用默认 [leading] 时, [title] 底部显示下划线
  final bool useUnderline;

}