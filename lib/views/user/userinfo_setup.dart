import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lj_netdisk/network/user/start.dart';
import 'package:lj_netdisk/network/user/user.dart';
import 'package:lj_netdisk/utils/struct/userinfo.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';
import 'package:lj_netdisk/widget/common/icon_text.dart';
import 'package:lj_netdisk/widget/user/common/bottom_layer.dart';
import 'package:lj_netdisk/widget/user/common/row.dart';
import 'package:lj_netdisk/widget/user/common/title.dart';

class UserInfoSetUpPage extends StatefulWidget {
  const UserInfoSetUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoSetUpState();
}

class _UserInfoSetUpState extends State<UserInfoSetUpPage> {
  /// 昵称控制器
  final TextEditingController _nameTextEditingController =
  TextEditingController();

  /// 个性签名控制器
  final TextEditingController _autographTextEditingController =
  TextEditingController();

  /// 用户信息
  StructUserInfo ui = StructUserInfo(
      id: "请登录",
      name: "请登录...",
      face: Image.asset("lib/assets/images/user_page/user.png"),
      phone: "***********",
      birth: DateTime.now(),
      autograph: "");

  @override
  void initState() {
    super.initState();
    _nameTextEditingController.text = "";
    _autographTextEditingController.text = "";

    /// 获取用户信息
    _getUserInfo();
  }

  Future _getUserInfo() async {
    var ui = await NetWorkUserIndex.getUserInfo();
    setState(() {
      this.ui = ui;
    });
  }

  /// 更新用户信息
  Future _updateUserInfo(StructUserInfo ui) async {
    final flag = await NetWorkUserIndex.updateUserInfo(ui);
    if (flag) {
      setState(() {
        this.ui = ui;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const textStyle01 = TextStyle(color: Colors.black);
    const textStyle02 = TextStyle(color: Colors.grey);
    _nameTextEditingController.text = ui.name;
    _autographTextEditingController.text = ui.autograph ?? "暂无个性签名";

    const double iconSize = 15;
    const Color iconsColor = Colors.grey;
    const EdgeInsets padding = EdgeInsets.only(left: 10, right: 10);
    const double height = 65;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomTitle(
        title: "个人信息",
        backgroundcolor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 1),
        children: <Widget>[
          CustomRow(
            height: height,
            onPressed: () {},
            padding: padding,
            children: [
              const Text("头像", style: textStyle01),
              Container(
                constraints: const BoxConstraints.expand(width: 45, height: 45),
                decoration: BoxDecoration(
                  image: DecorationImage(image: ui.face.image),
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ],
          ),
          CustomRow(
            height: height,
            padding: padding,
            children: [
              const Text("账号", style: textStyle01),
              CustomIconText(
                ui.id,
                style: textStyle02,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
            onPressed: () => {},
          ),
          CustomRow(
            height: height,
            padding: padding,
            children: [
              const Text("昵称", style: textStyle01),
              CustomIconText(
                ui.name.length > 20
                    ? ui.name.substring(0, 20) + "..."
                    : ui.name,
                style: textStyle02,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              )
            ],
            onPressed: () {
              CustomBottom.bottomDialog(
                context: context,
                title: "设置昵称",
                height: 180,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: TextField(
                      style: const TextStyle(fontSize: 16),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "昵称",
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.only(
                          top: 0,
                          bottom: 0,
                          left: 10,
                        ),
                        counterText:
                        "${_nameTextEditingController.text.length}/20",
                      ),
                      controller: _nameTextEditingController,
                    ),
                  ),
                ],
                onOk: () {
                  Navigator.pop(context);
                  ui.name = _nameTextEditingController.text;
                  _updateUserInfo(ui);
                },
                onCancel: () {
                  Navigator.pop(context);
                  _nameTextEditingController.text = ui.name;
                },
              );
            },
          ),
          CustomRow(
            height: height,
            padding: padding,
            children: [
              const Text("我的生日", style: textStyle01),
              CustomIconText(
                "${ui.birth!.year}/${ui.birth!.month.toString().padLeft(2, '0')}/${ui.birth!.day.toString().padLeft(2, '0')}",
                style: textStyle02,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
            onPressed: () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                theme: const DatePickerTheme(backgroundColor: Colors.white),
                minTime: DateTime(1890, 3, 5),
                maxTime: DateTime.now(),
                onConfirm: (value) {
                  ui.birth = value;
                  _updateUserInfo(ui);
                },
                currentTime: ui.birth,
                locale: LocaleType.zh,
              );
            },
          ),
          CustomRow(
            height: height,
            padding: padding,
            offstage: false,
            children: [
              const Text("个性签名", style: textStyle01),
              CustomIconText(
                ui.autograph!.length > 15
                    ? ui.autograph!.substring(0, 15) + "..."
                    : ui.autograph!,
                style: textStyle02,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
            onPressed: () {
              CustomBottom.bottomDialog(
                context: context,
                height: 180,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: TextField(
                      controller: _autographTextEditingController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        //是否填充背景色
                        filled: true,
                        //设置背景色，filled 为 true 时生效
                        fillColor: Color(0xfff2f2f2),
                        contentPadding: EdgeInsets.all(10.0),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 14),
                      autofocus: true,
                      maxLines: 4,
                    ),
                  ),
                ],
                onOk: () {
                  Navigator.pop(context);
                  ui.autograph = _autographTextEditingController.text;
                  _updateUserInfo(ui);
                },
                onCancel: () {
                  Navigator.pop(context);
                  _autographTextEditingController.text = ui.autograph ?? "";
                },
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
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
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () async {
                await NetWorkStartIndex.logOut();
                await LocalStorage.remove("credentials");
                Navigator.pushNamedAndRemoveUntil(
                    context, "launch", (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
