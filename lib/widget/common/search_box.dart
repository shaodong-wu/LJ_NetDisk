import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/widget/common/search.dart';

// 搜索框
class CustomSearchBox extends StatefulWidget {

  /// 搜索关键字
  final String? query;

  /// 搜索框内提示文本
  final String title;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 搜索框背景颜色
  final Color? backgroundColor;

  /// 自定义搜索页
  final CustomSearchDelegate delegate;

  const CustomSearchBox({
    Key? key,
    this.query,
    required this.title,
    this.padding = const EdgeInsets.only(top: 10, bottom: 10, left: 18.0),
    required this.delegate,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomSearchBoxState createState() => _CustomSearchBoxState();
}

class _CustomSearchBoxState extends State<CustomSearchBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: widget.padding,
        decoration: ShapeDecoration(
            color: widget.backgroundColor ?? Colors.white,
            shape: const StadiumBorder()
        ),
        alignment: Alignment.centerLeft,
        child: Text.rich(
          TextSpan(
            style: const TextStyle(
                color: Color.fromRGBO(176, 177, 179, 1),
                fontSize: 14
            ),
            children: [
              WidgetSpan(child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(IconfontsData.sousuo, color: Colors.grey, size: 18),
              )),
              TextSpan(text: widget.title)
            ]
          )
        )
      ),
      onTap: () {
        showCustomSearch(context: context, query: widget.query, delegate: widget.delegate);
      },
    );
  }
}