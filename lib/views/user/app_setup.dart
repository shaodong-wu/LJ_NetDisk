import 'package:flutter/material.dart';
import 'package:lj_netdisk/models/app_setup_model.dart';
import 'package:lj_netdisk/network/user/start.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';
import 'package:lj_netdisk/widget/common/icon_text.dart';
import 'package:lj_netdisk/widget/user/common/row.dart';
import 'package:lj_netdisk/widget/user/common/title.dart';
import 'package:provider/provider.dart';

class AppSetUpPage extends StatefulWidget {
  const AppSetUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppSetUpPageState();
}

class _AppSetUpPageState extends State<AppSetUpPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _cardWiget({required List<Widget> children}) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 15),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle firstTextStyle =
    TextStyle(color: Colors.black, fontSize: 15);
    const TextStyle secondTextStyle =
    TextStyle(color: Colors.grey, fontSize: 12);
    final appSettingModel = Provider.of<AppSettingModel>(context);
    const double iconSize = 15;
    const Color iconsColor = Colors.grey;
    const double height = 55;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 253, 1),
      appBar: const CustomTitle(
        title: "设置",
      ),
      body: ListView(
        children: [
          _cardWiget(
            children: [
              CustomRow(
                height: height,
                onPressed: () => Navigator.pushNamed(context, "userinfo-setup"),
                children: const [
                  Text("个人信息", style: firstTextStyle),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: iconSize,
                    color: iconsColor,
                  ),
                ],
              ),
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("账号管理", style: firstTextStyle),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: iconSize,
                    color: iconsColor,
                  ),
                ],
              ),
            ],
          ),
          _cardWiget(
            children: [
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("自动备份", style: firstTextStyle),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: iconSize,
                    color: iconsColor,
                  ),
                ],
              ),
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("网络设置", style: firstTextStyle),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: iconSize,
                    color: iconsColor,
                  ),
                ],
              ),
            ],
          ),
          _cardWiget(
            children: [
              /// 设备管理
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("设备管理", style: firstTextStyle),
                  CustomIconText(
                    "",
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 下载设置
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("下载设置", style: firstTextStyle),
                  CustomIconText(
                    "",
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 自动识别笔记连接
              CustomRow(
                height: height,
                onPressed: () {},
                children: [
                  const Text("自动识别笔记连接", style: firstTextStyle),
                  Switch(
                      value: appSettingModel.noteSwitch,
                      onChanged: (value) {
                        appSettingModel.setData(
                          noteSwitch: value,
                          nightMode: appSettingModel.nightMode,
                        );
                      })
                ],
              ),

              /// 夜间模式
              CustomRow(
                height: height,
                onPressed: () {},
                children: [
                  const Text("夜间模式", style: firstTextStyle),
                  Switch(
                      value: appSettingModel.nightMode,
                      onChanged: (value) {
                        appSettingModel.setData(
                          nightMode: value,
                          noteSwitch: appSettingModel.noteSwitch,
                        );
                      })
                ],
              ),

              /// 文件夹设置
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("文件夹设置", style: firstTextStyle),
                  CustomIconText(
                    "",
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 消息提醒设置
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("消息提醒设置", style: firstTextStyle),
                  CustomIconText(
                    "语音提示上线了",
                    style: secondTextStyle,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 高级设置
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("高级设置", style: firstTextStyle),
                  CustomIconText(
                    "",
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 检查新版本
              CustomRow(
                height: height,
                onPressed: () {},
                children: const [
                  Text("检查新版本", style: firstTextStyle),
                  CustomIconText(
                    "V1.0.0",
                    style: secondTextStyle,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),

              /// 关于
              CustomRow(
                height: height,
                offstage: false,
                onPressed: () {},
                children: const [
                  Text("关于", style: firstTextStyle),
                  CustomIconText(
                    "",
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: iconSize,
                      color: iconsColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: 50,
            ),
            child: ElevatedButton(
              child: const Text('退出登录'),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    const Size.fromWidth(double.maxFinite)),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.only(top: 13, bottom: 13)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23))),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () async {
                await NetWorkStartIndex.logOut();
                await LocalStorage.remove("credentials");
                Navigator.pushNamedAndRemoveUntil(
                    context, 'launch', (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
