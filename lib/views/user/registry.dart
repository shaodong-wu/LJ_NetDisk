import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/widget/user/common/agreement_policy.dart';
import 'package:vibration/vibration.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class UserRegisterPageIndex extends StatefulWidget {
  const UserRegisterPageIndex({Key? key}) : super(key: key);

  @override
  _RegisterPageIndexState createState() => _RegisterPageIndexState();
}

class _RegisterPageIndexState extends State<UserRegisterPageIndex> {

  /// String phoneNumber;
  bool _isReadAndAgree = false;

  /// 是否禁用注册按钮
  bool _isDisableButton = true;

  /// 文本输入框控制器
  final TextEditingController _phoneNumberController = TextEditingController();

  /// 抖动动画控制器
  final ShakeAnimationController _shakeAnimationController = ShakeAnimationController();

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(() {
      if (_phoneNumberController.text.length == 11) {
        setState(() => _isDisableButton = false);
      } else {
        setState(() => _isDisableButton = true);
      }
    });
  }

  /// 修改已同意协议
  void _setIsReadAndAgree(bool? newValue) {
    if (newValue != null) {
      setState(() {
        _isReadAndAgree = newValue;
      });
    }
  }

  /// 手机震动提示
  void _vibrationPrompt() async {
    /// 判断是否勾选协议 抖动动画是否执行
    if (!_isReadAndAgree && !_shakeAnimationController.animationRunging) {
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
              height: 500,
              decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(28.0)),
              ),
              padding: const EdgeInsets.only(top: 35, left: 30, right: 30),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  /// 网盘LOGO 盒子
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        // 网盘 LOGO
                        Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Image.asset(CommonImagesData.netDiskLogo, width: 100, height: 100)
                        ),
                        // 标题
                        Text('欢迎注册浪尖账号', style: DefaultTextStyles.bigTitleStyle),
                      ]
                    ),
                  ),

                  /// 输入框
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(247, 245, 246, 1),
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                    ),
                    margin: const EdgeInsets.only(top: 60, bottom: 30),
                    child: Form(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              '+86',
                              textAlign: TextAlign.right,
                              style: DefaultTextStyles.mobilePrefixTextStyle
                            ),
                          ),
                          Container(
                            width: 185,
                            margin: const EdgeInsets.only(left: 12),
                            child: Center(
                              child: TextFormField(
                                controller: _phoneNumberController,
                                cursorWidth: 1.0,
                                style: DefaultTextStyles.regInputTextStyle,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.singleLineFormatter
                                ],
                                decoration: InputDecoration(
                                  hintText: '请输入手机号',
                                  //文本框的尾部图标
                                  suffixIcon: _phoneNumberController.text.isNotEmpty ? IconButton(
                                      onPressed: () {
                                        _phoneNumberController.clear();
                                      },
                                      icon: const Icon(Icons.cancel, color: Color.fromRGBO(196, 196, 196, 1), size: 18.0)
                                  ) : null,
                                  hintStyle: DefaultTextStyles.regInputHintStyle,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            )
                          )
                        ],
                      ),
                    )
                  ),

                  /// 注册按钮
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      child: Text('立即注册', style: DefaultTextStyles.regBtnTextStyle),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                          _isDisableButton
                              ? const Color.fromRGBO(202, 212, 248, 1)
                              : const Color.fromRGBO(77, 110, 241, 1)
                      )),
                      onPressed: _isDisableButton ? null : _vibrationPrompt,
                    ),
                  ),

                  /// 勾选协议
                  AgreementPolicy(
                    isReadAndAgree: _isReadAndAgree,
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