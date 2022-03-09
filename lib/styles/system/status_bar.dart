part of styles;

class SystemStatusBarStyles {
  /// 系统状态栏_白色透明
  static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
    // 导航栏颜色设置
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    /// 通知栏背景颜色
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  /// 系统状态栏_黑色透明
  static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
    // 导航栏颜色设置
    systemNavigationBarColor: Colors.white,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,

    /// 通知栏背景颜色
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  );
}