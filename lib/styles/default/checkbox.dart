part of styles;

class DefaultCheckBoxStyles {

  static const checkboxTheme = CheckboxThemeData(
    shape: CircleBorder(), // 实现圆形效果
    visualDensity: VisualDensity.compact,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    side: BorderSide(
        width: 2.0,
        color: Color.fromRGBO(225, 225, 225, 1)
    ),
  );

}