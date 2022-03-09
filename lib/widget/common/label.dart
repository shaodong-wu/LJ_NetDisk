import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///创建小标签
class CustomLabel extends StatefulWidget {

  ///标签列表
  final List textList;

  ///标签左侧的 widget
  final Widget? avatar;

  ///文本的大小
  final double fontSize;

  ///小标签间的水平间距,仅 isSilde为 false时有效
  final double spacing;

  ///小标签间的垂直间距,仅 isSilde为 false时有效
  final double runSpacing;

  ///小标签的边界形状
  final OutlinedBorder? shape;

  ///单次点击事件
  final ValueChanged<int> onTap;

  ///设置小标签的最小 width
  final double minWith;

  ///小标签的内间距
  final EdgeInsetsGeometry? labelPadding;

  ///是否不使用 Wrap 使小标签水平可滑动
  final bool isSlide;

  const CustomLabel({
    Key? key,
    required this.textList,
    required this.onTap,
    this.avatar,
    this.spacing = 8,
    this.runSpacing = 3,
    this.fontSize = 13,
    this.shape,
    this.minWith = 0,
    this.labelPadding,
    this.isSlide = false,
  }) : super(key: key);

  @override
  _CustomLabelState createState() => _CustomLabelState();
}

class _CustomLabelState extends State<CustomLabel> {

  /// 当前索引
  int _currentIndex = -1;

  List<Widget> labelList(BuildContext context) {
    // List _textTypeList = textList.runtimeType == List<String> ?
    var list = widget.textList.asMap().entries.map((item) {
      var text = item.value;
      Icon? icon;
      if (item.value.runtimeType != String) {
        icon = Icon(
          item.value["icon"],
          size: 20,
        );
        text = item.value["text"];
      }
      return Container(
        margin: widget.isSlide ? const EdgeInsets.fromLTRB(6, 0, 6, 0):null,
        child: ChoiceChip(
          labelPadding: widget.labelPadding,
          shape: widget.shape ?? const StadiumBorder(),
          avatar: icon ?? widget.avatar,
          backgroundColor: Colors.white38,
          selected: _currentIndex == item.key,
          selectedColor:  const Color.fromRGBO(168, 220, 243, 150),
          label: Container(
            constraints: BoxConstraints(maxWidth: 80, minWidth: widget.minWith),
            child: Text(
              text.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: widget.fontSize,
              ),
            ),
          ),
          onSelected: (index) {
            setState(() {
              _currentIndex = item.key;
            });
            widget.onTap(item.key);
          }
        ),
      );
    });
    return list.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: widget.isSlide ? SizedBox(
        height: 30,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: labelList(context),
        ),
      ) : Wrap(
        spacing: widget.spacing,
        runSpacing: widget.runSpacing,
        children: labelList(context),
      ),
    );
  }

}
