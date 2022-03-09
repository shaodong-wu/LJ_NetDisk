import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/network/user/start.dart';
import 'package:lj_netdisk/network/user/vcode.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';
import 'package:lj_netdisk/utils/tools/animation_navigation.dart';
import 'package:lj_netdisk/widget/user/common/agreement_policy.dart';
import 'package:vibration/vibration.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class UserLoginPageIndex extends StatefulWidget {

  const UserLoginPageIndex({Key? key}) : super(key: key);

  @override
  _UserLoginPageIndexState createState() => _UserLoginPageIndexState();
}

class _UserLoginPageIndexState extends State<UserLoginPageIndex> {

  /// 用户的输入账号
  String account = '';

  /// 用户输入的密码
  String password = '';

  /// 错误提示文本
  String errorText = '';

  /// 是否已阅读协议;
  bool isReadAndAgree = false;

  /// 是否密码显示为明文
  bool _obscureText = true;

  /// 文本输入框控制器
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _passwordNumberController = TextEditingController();

  /// 抖动动画控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();

  @override
  void initState() {
    super.initState();
    _accountNumberController.addListener(() {
      setState(() => account = _accountNumberController.text);
    });
    _passwordNumberController.addListener(() {
      setState(() => password = _passwordNumberController.text);
    });
  }

  /// 修改已同意协议
  void _setIsReadAndAgree(bool? newValue) {
    if (newValue != null) {
      setState(() {
        isReadAndAgree = newValue;
      });
    }
  }

  /// 手机震动提示
  Future<void> _vibrationPrompt() async {
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
    }
  }

  /// 检查验证码
  void _checkVCode(String code) async {
    StructResponseResult vcodeResult = await NetWorkVCodeIndex.checkImageVCode(code);
    if (vcodeResult.code == StateCode.SUCCESS) {
      StructResponseResult loginResult = await NetWorkStartIndex.login(account, password, vcodeResult.data);
      if (loginResult.code == StateCode.SUCCESS) {
        AnimationNavigation.pushAndRemoveUntil(context, '/');
      } else {
        setState(() => errorText = loginResult.message);
      }
    }
  }

  /// 用户登录
  void _showVCode() async {
    RegExp mobile = RegExp(r'^(?![0-9]+$)[0-9a-zA-Z.]{6,20}$');

    if (!isReadAndAgree) {
      await _vibrationPrompt();
      return;
    }

    if (mobile.hasMatch(password)) {
      setState(() => errorText = '');
      // 发起请求
      StructResponseResult result = await NetWorkVCodeIndex.getImageVCode();
      if (result.code == StateCode.SUCCESS) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.memory(
                base64.decode((result.data as String).split(',')[1]),
                width: 200,
                height: 50,
                fit: BoxFit.fill,
                gaplessPlayback:true,  // 防止重绘
              ),
              content: TextField(
                cursorWidth: 1.0,
                onSubmitted: (newValue) => _checkVCode(newValue),
              )
            );
          },
        );
      } else {
        setState(() => errorText = result.message);
      }
    } else {
      setState(() => errorText = '用户密码格式错误');
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 设置系统状态栏
    SystemChrome.setSystemUIOverlayStyle(SystemStatusBarStyles.light);

    /// 返回子Widget
    return Scaffold(
        body: GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(CommonImagesData.loginBgImage),
                  alignment: Alignment.topCenter
              )
            ),
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: 450,
                decoration:  const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(28.0)),
                ),
                padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    /// Title 盒子
                    Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      child: Text('登录浪尖账号 精彩永相随', style:  DefaultTextStyles.bigTitleStyle),
                    ),

                    /// 用户输入格式错误提示
                    Container(
                      height: 20,
                      margin: const EdgeInsets.only(top: 50),
                      child: Text(errorText, style: DefaultTextStyles.errorTextStyle),
                    ),

                    /// 账号输入框
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(247, 245, 246, 1),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      margin: const EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 280,
                            padding: const EdgeInsets.only(left: 30),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _accountNumberController,
                              cursorWidth: 1.0,
                              style: DefaultTextStyles.regInputTextStyle,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(12),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '请输入账号/手机号码',
                                //文本框的尾部图标
                                suffixIcon: account.isNotEmpty ? IconButton(
                                    onPressed: () {
                                      _accountNumberController.clear();
                                      setState(() => account = '');
                                    },
                                    icon: Icon(
                                        IconfontsData.cancel,
                                        color: const Color.fromRGBO(196, 196, 196, 1),
                                        size: 18.0
                                    )
                                ) : null,
                                hintStyle: DefaultTextStyles.regInputHintStyle,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            )
                          )
                        ],
                       )
                    ),

                    /// 密码输入框
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(247, 245, 246, 1),
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      margin: const EdgeInsets.only(top: 23, bottom: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 280,
                            padding: const EdgeInsets.only(left: 30),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _passwordNumberController,
                              cursorWidth: 1.0,
                              obscureText: _obscureText,
                              style: DefaultTextStyles.regInputTextStyle,
                              decoration: InputDecoration(
                                hintText: '请输入密码',
                                suffixIcon: _obscureText ? IconButton(
                                    onPressed: () => setState(() {
                                      _obscureText = false;
                                    }),
                                    icon: Icon(IconfontsData.hidden, color: const Color.fromRGBO(196, 196, 196, 1), size: 18.0)
                                ) : IconButton(
                                    onPressed: () => setState(() {
                                      _obscureText = true;
                                    }),
                                    icon: Icon(IconfontsData.show, color: const Color.fromRGBO(196, 196, 196, 1), size: 18.0)
                                ),
                                hintStyle: DefaultTextStyles.regInputHintStyle,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            )
                          )
                        ],
                      )
                    ),

                    /// 注册按钮
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        child: Text('登录', style: DefaultTextStyles.regBtnTextStyle),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                            account.isEmpty || password.isEmpty
                          ? const Color.fromRGBO(202, 212, 248, 1)
                          : const Color.fromRGBO(77, 110, 241, 1)
                        )),
                        onPressed: account.isEmpty || password.isEmpty ? null : _showVCode,
                      ),
                    ),

                    /// 勾选协议
                    AgreementPolicy(
                      isReadAndAgree: isReadAndAgree,
                      shakeAnimationController: _shakeAnimationController,
                      onChanged: _setIsReadAndAgree
                    ),
                  ],
                ),
              ),
            )
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        )
    );
  }
}