import 'package:flutter/material.dart';
import 'package:lj_netdisk/project_router.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';
import 'package:lj_netdisk/views/entrance.dart';
import 'package:lj_netdisk/views/user/launch.dart';
import 'package:provider/provider.dart';

import 'models/app_setup_model.dart';
import 'models/userinfo_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfoModel()),
        ChangeNotifierProvider(create: (context) => AppSettingModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with  WidgetsBindingObserver {

  /// 用户的登录状态
  bool _isLogin = false;

  @override
  void initState() {
    super.initState();
    _setLoginState();
  }

  /// 设置上次是否已登录
  void _setLoginState() async {
    List? credentials = await LocalStorage.get('credentials');
    bool isExist = await LocalStorage.hasKay('credentials');
    setState(() {
      _isLogin = isExist;
    });

    debugPrint('[当前客户端是否登录]: ${ _isLogin.toString()}');
    debugPrint('[credentials]: ${credentials == null ? '未登录' : credentials[0]}');
    debugPrint('[credentials]: ${credentials == null ? '未登录' : credentials[1]}');
  }

  @override
  Widget build(BuildContext context)  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '浪尖网盘',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent
          ),
          buttonTheme: DefaultBtnStyles.buttonTheme,
          textButtonTheme: DefaultBtnStyles.textButtonTheme,
          elevatedButtonTheme: DefaultBtnStyles.elevatedButtonTheme,
          checkboxTheme: DefaultCheckBoxStyles.checkboxTheme,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              elevation: 0,
              highlightElevation: 0,
              splashColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              sizeConstraints: BoxConstraints(
                  maxWidth: 80,
                  maxHeight: 80
              )
          )
      ),
      routes: ProjectRouter().registerRouter(),
      home: _isLogin ? Entrance() : const UserLaunchPageIndex(),
    );
  }
}
