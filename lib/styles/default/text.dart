part of styles;

class DefaultTextStyles {

  /// 大标题文本样式
  static TextStyle bigTitleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 23,
    fontWeight: FontWeight.bold
  );

  static TextStyle mobilePrefixTextStyle = const TextStyle(
      color: Color.fromRGBO(84, 84, 84, 1),
      fontSize: 20,
      fontWeight: FontWeight.bold
  );

  /// 注册大按钮文本样式
  static TextStyle regBtnTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  /// 注册输入框文本样式
  static TextStyle regInputTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  /// 注册输入框提示样式
  static TextStyle regInputHintStyle = const TextStyle(
    color: Color.fromRGBO(182, 182, 182, 1),
    fontSize: 20,
    fontWeight: FontWeight.w500
  );

  /// 错误文本提示样式
  static TextStyle errorTextStyle = const TextStyle(
      color: Colors.red,
      fontSize: 14,
      fontWeight: FontWeight.w500
  );

  /// 卡片标题字体样式
  static TextStyle cardTilteTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: _oneLevelFontSize,
    fontWeight: FontWeight.w900,
  );

  /// 卡片内容描述字体样式
  static TextStyle cardBodyTextStyle = const TextStyle(
    color: Colors.grey,
    fontSize: _twoLevelFontSize,

  );

  /// 按钮文本样式
  static TextStyle buttonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: _thereLevelFontSize,
  );

  static TextStyle sketchTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: _thereLevelFontSize,
  );

  /// 网盘条款名称样式
  static TextStyle netDiskClauseTextStyle = const TextStyle(
      color: Color.fromRGBO(113, 113, 113, 1),
      fontSize: _thereLevelFontSize,
  );

  /// 隐私政策条款名称样式
  static TextStyle privacyClauseTextStyle = const TextStyle(
    color: Color.fromRGBO(113, 113, 113, 1),
    fontSize: _fourLevelFontSize,
  );

  /// 提示与问候语字体样式
  static TextStyle tipGreetingStyle = const TextStyle(
    color: Colors.grey,
    fontSize: _fourLevelFontSize,
  );


  /// 默认应用程序 一级字体大小
  static const double _oneLevelFontSize = 18.0;

  /// 默认应用程序 二级字体大小
  static const double _twoLevelFontSize = 14.0;

  /// 默认应用程序 三级字体大小
  static const double _thereLevelFontSize = 13.0;

  /// 默认应用程序 四级字体大小
  static const double _fourLevelFontSize = 12.0;

}