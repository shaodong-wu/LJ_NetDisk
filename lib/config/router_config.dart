import 'package:lj_netdisk/utils/struct/router.dart';
import 'package:lj_netdisk/views/file/index.dart';
import 'package:lj_netdisk/views/home/index.dart';
import 'package:lj_netdisk/views/user/app_setup.dart';
import 'package:lj_netdisk/views/user/index.dart';
import 'package:lj_netdisk/views/user/launch.dart';
import 'package:lj_netdisk/views/user/login.dart';
import 'package:lj_netdisk/views/user/registry.dart';
import 'package:lj_netdisk/views/user/userinfo_setup.dart';

class RouterConfig {
  /// 路由配置信息
  /// widget 为组件
  /// entranceIndex 为首页位置，如果非首页则为-1
  /// params 为组件需要的参数数组
  static Map<String, StructRouter> routerMapping = {
    '/': StructRouter(HomePageIndex(), 0, null, false),
    'home': StructRouter(HomePageIndex(), 0, null, true),
    'file': const StructRouter(FilePageIndex(), 1, null, true),
    'user': const StructRouter(UserPageIndex(), 3, null, true),
    'userinfo-setup': const StructRouter(UserInfoSetUpPage(), -1, null, false),
    'app-setup': const StructRouter(AppSetUpPage(), -1, null, false),
    'launch': const StructRouter(UserLaunchPageIndex(), -1, null, false),
    'login': const StructRouter(UserLoginPageIndex(), -1, null, false),
    'registry': const StructRouter(UserRegisterPageIndex(), -1, null, false),
    // 'error': const StructRouter(CustomError(), -1, ['errorCode', 'action'], false),
  };
}