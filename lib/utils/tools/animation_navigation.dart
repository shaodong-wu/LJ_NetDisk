import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/project_router.dart';
import 'package:lj_netdisk/views/entrance.dart';

class AnimationNavigation {

  /// 从右边划入, 划出
  static SlideTransition _createTransition(Animation<double>  animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset> (
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  /// 根据路由名字跳转
  static void pushNamed(BuildContext context, String routeName) {
    Widget pageWidget = ProjectRouter().getPageByRouter(routeName);
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return pageWidget;
      },
      transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return _createTransition(animation, child);
      }
    ));
  }

  /// 根据 Widget 跳转
  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return widget;
        },
        transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          return _createTransition(animation, child);
        }
    ));
  }

  /// 根据路由名字跳转, 并从栈中移除
  static void pushAndRemoveUntil(BuildContext context, String routeName) {
    int indexValue = ProjectRouter().open(context, routeName);
    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Entrance(indexValue: indexValue);
      },
      transitionsBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return _createTransition(animation, child);
      }
    ), (router) => false);
  }
}