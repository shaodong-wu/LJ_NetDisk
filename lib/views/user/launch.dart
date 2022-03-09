import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/common/login_mode_data.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/utils/tools/animation_navigation.dart';
import 'package:lj_netdisk/widget/common/icon_text.dart';
import 'package:lj_netdisk/widget/user/common/agreement_policy.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:vibration/vibration.dart';

import '../entrance.dart';

class UserLaunchPageIndex extends StatefulWidget {
  const UserLaunchPageIndex({Key? key}) : super(key: key);

  @override
  _UserLaunchPageIndexState createState() => _UserLaunchPageIndexState();
}

class _UserLaunchPageIndexState extends State<UserLaunchPageIndex> {

  /// 是否同意协议
  bool isReadAndAgree = false;

  /// 抖动动画控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();

  /// 修改已同意协议
  void _setIsReadAndAgree(bool? newValue) {
    if (newValue != null) {
      setState(() {
        isReadAndAgree = newValue;
      });
    }
  }

  /// 手机震动提示
  Future<bool> _vibrationPrompt() async {
    /// 判断是否勾选协议 抖动动画是否执行
    if (!isReadAndAgree && !_shakeAnimationController.animationRunging) {
      _shakeAnimationController.start();
      /// 手机振动提示
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(duration: 500);
      } else {
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 500));
        Vibration.vibrate();
      }
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /// 设置系统状态栏
    SystemChrome.setSystemUIOverlayStyle(SystemStatusBarStyles.light);

    /// 第三方登录模块
    List<Widget> buildLoginMode = LoginModeData.modeList.map((e) {
      return IconButton(
        iconSize: 38.0,
        icon: Image.asset(e['logoImage'] as String),
        padding: const EdgeInsets.all(13.0),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () async {
          bool result = await _vibrationPrompt();
          if (result && e['onPressed'] != null) {
            e['onPressed']();
          }
        },
      );
    }).toList();

    /// 返回子Widget
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// 网盘大 LOGO
          Container(
            padding: const EdgeInsets.only(top: 60),
            child: Image.asset(CommonImagesData.netDiskBigLogo),
          ),

          /// 登录方式与勾选协议
          Container(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 32, bottom: 50),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('浪尖账号登录'),
                  onPressed: () {
                    AnimationNavigation.pushNamed(context, 'login');
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: buildLoginMode
                  ),
                ),
                TextButton(
                  child: CustomIconText(
                    '手机号注册',
                    icon: const Icon(Icons.keyboard_arrow_right, color: Colors.black,),
                    iconSize: 18,
                    style: DefaultTextStyles.sketchTextStyle
                  ),
                  onPressed: () {
                    AnimationNavigation.pushNamed(context, 'registry');
                  },
                ),
                AgreementPolicy(
                  isReadAndAgree: isReadAndAgree,
                  shakeAnimationController: _shakeAnimationController,
                  onChanged: _setIsReadAndAgree
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
