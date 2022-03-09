import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/utils/tools/animation_navigation.dart';
import 'package:lj_netdisk/views/common/web_view.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class AgreementPolicy extends StatelessWidget {

  const AgreementPolicy({
    Key? key,
    this.isReadAndAgree = false,
    required this.shakeAnimationController,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShakeAnimationWidget(
      /// 抖动控制器
      shakeAnimationController: shakeAnimationController,
      /// 抖动方向
      shakeAnimationType: ShakeAnimationType.LeftRightShake,
      /// 抖动幅度
      shakeRange: 0.6,
      /// 设置不开启抖动
      isForward: false,
      /// 执行抖动动画的子Widget
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: isReadAndAgree,
            shape: const CircleBorder(), // 实现圆形效果
            splashRadius: 0,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: const BorderSide(
                width: 2.0,
                color: Color.fromRGBO(183, 183, 183, 1)
            ),
            onChanged: onChanged,
          ),
          Text('请您阅读并同意', style: DefaultTextStyles.tipGreetingStyle),
          TextButton(
            child: Text('浪尖网盘用户协议', style: DefaultTextStyles.netDiskClauseTextStyle),
            onPressed: () {
              // 打开本地网页
              AnimationNavigation.push(context, WebViewPage(
                  title: '用户协议',
                  isLocalUrl: true,
                  url: 'lib/assets/html/浪尖网盘服务协议.html'
              ));
            },
          ),
          Text('和', style: DefaultTextStyles.tipGreetingStyle),
          TextButton(
            child: Text('隐私协议', style: DefaultTextStyles.privacyClauseTextStyle),
            onPressed: () {
              // 打开本地网页
              AnimationNavigation.push(context, WebViewPage(
                  title: '隐私政策',
                  isLocalUrl: true,
                  url: 'lib/assets/html/浪尖网盘隐私政策.html'
              ));
            },
          ),
        ],
      ),
    );
  }

  // 是否阅读和同意
  final bool isReadAndAgree;

  /// 抖动动画控制器
  final ShakeAnimationController shakeAnimationController;

  /// 修改后触发动作
  final void Function(bool?)? onChanged;
}