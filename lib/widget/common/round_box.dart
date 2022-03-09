import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundBox extends StatelessWidget {

  const CustomRoundBox({
    Key? key,
    this.width = 40,
    this.height = 40,
    this.margin,
    required this.child,
    this.clickAction,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle
        ),
        child: child,
      ),
      onTap: () {
        if (clickAction != null) {
          clickAction!();
        }
      },
    );
  }

  /// 圆形盒子的宽度
  final double width;

  /// 圆形盒子的高度
  final double height;

  /// 圆形盒子外边距
  final EdgeInsetsGeometry? margin;

  /// 圆形盒子的子 [Widget]
  final Widget child;

  /// 盒子的背景颜色
  final Color backgroundColor;

  /// 盒子的点击事件
  final void Function()? clickAction;
}