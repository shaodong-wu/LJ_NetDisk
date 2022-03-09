///
/// 带图标的Text - IconText(修改后)
///
/// @Author 我爱我家喵喵
/// @Modify wu_shaodong
/// @PublishDate 2020-07-02 10:04
/// @ModifyDate  2021-12-16 02:52
/// @Source https://www.cnblogs.com/yangyxd/p/13223134.html
///

import 'package:flutter/material.dart';

class CustomIconText extends StatelessWidget {

  const CustomIconText(this.text, {
    Key? key,
    required this.icon,
    this.iconSize = 24,
    this.direction = Axis.horizontal,
    this.style,
    this.maxLines = 1,
    this.softWrap,
    this.padding,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = DefaultTextStyle.of(context).style.merge(style);
    return text.isEmpty ? (padding == null ? icon : Padding(padding: padding as EdgeInsetsGeometry, child: icon))
        : RichText(
      text: TextSpan(
          style: _style,
          children: [
            TextSpan(text: direction == Axis.horizontal ? text : "\n$text"),
            WidgetSpan(
                child: IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: _style.color,
                  ),
                  child: padding == null ? icon : Padding(
                    padding: padding as EdgeInsetsGeometry,
                    child: icon,
                  ),
                )
            ),
          ]
      ),
      maxLines: maxLines,
      softWrap: softWrap ?? true,
      overflow: overflow,
      textAlign: textAlign ?? (
          direction == Axis.horizontal ? TextAlign.start : TextAlign.center
      ),
    );
  }

  /// 文本内容
  final String text;

  /// Icon图标
  final Widget icon;

  /// Icon图标大小
  final double iconSize;

  /// 文本水平方向
  final Axis direction;

  /// Icon图标内边距
  final EdgeInsetsGeometry? padding;

  /// 文本内容样式
  final TextStyle? style;

  /// 最大限制行数
  final int maxLines;

  /// 软包装
  final bool? softWrap;

  /// 文本溢出
  final TextOverflow overflow;

  /// 文本内容位置
  final TextAlign? textAlign;
}