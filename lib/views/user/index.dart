import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/models/userinfo_model.dart';
import 'package:lj_netdisk/network/request.dart';
import 'package:lj_netdisk/utils/struct/userinfo.dart';
import 'package:lj_netdisk/widget/common/card.dart';
import 'package:lj_netdisk/widget/common/icon_text.dart';
import 'package:lj_netdisk/widget/user/common/row.dart';
import 'package:provider/provider.dart';

class UserPageIndex extends StatefulWidget {
  const UserPageIndex({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageIndexState();
}

class _UserPageIndexState extends State<UserPageIndex> {
  ///总容量
  final double totalSize = 2068;

  /// 已经使用的容量
  double useSize = Random().nextDouble() * Random().nextInt(2000);

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

    /// 获取用户信息
    _getUserInfo();
  }

  /// 获取用户信息
  Future _getUserInfo() async {
    try {
      var res =
      await NetWorkRequest.request(url: "/api/user/info", method: 'GET');
      if (res["code"].toString() == "0") {
        /// 更新用户信息
        setState(() {
          ui = StructUserInfo.fromJson(res["results"]);
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  /// 头像
  Widget _headerBody(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, "userinfo-setup")
              .then((value) => _getUserInfo());
        },
        child: Row(
          children: <Widget>[
            Container(
                constraints: const BoxConstraints.expand(width: 80, height: 80),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ui.face.image,
                  ),
                  borderRadius: BorderRadius.circular(80),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        ui.name.length > 12
                            ? ui.name.substring(0, 12) + "..."
                            : ui.name,
                        textAlign: TextAlign.left,
                        style:
                        const TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      Image.asset(
                        CommonImagesData.personalSelectedIcon,
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  Text(
                    ui.autograph!.length > 15
                        ? ui.autograph!.substring(0, 15) + "..."
                        : ui.autograph!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 卡片导航
  Widget _cardBody() {
    const double iconWidth = 35;
    // ignore: unused_local_variable
    const double iconHeight = iconWidth;
    const double iconSize = 25;
    const textStyle = TextStyle(color: Colors.black, fontSize: 12);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: TextButton(
            onPressed: () {},
            child: Column(
              children: const [
                Icon(
                  Icons.grade_outlined,
                  size: iconSize,
                  color: Colors.black,
                ),
                Text(
                  "我的收藏",
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: const [
                  Icon(
                    Icons.share,
                    size: iconSize,
                    color: Colors.black,
                  ),
                  Text(
                    "我的分享",
                    style: textStyle,
                  ),
                ],
              ),
            )),
        Expanded(
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: const [
                  Icon(
                    Icons.delete_outline,
                    size: iconSize,
                    color: Colors.black,
                  ),
                  Text(
                    "回收站",
                    style: textStyle,
                  ),
                ],
              ),
            )),
        Expanded(
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: const [
                  Icon(
                    Icons.important_devices,
                    size: iconSize,
                    color: Colors.black,
                  ),
                  Text(
                    "设备管理",
                    style: textStyle,
                  ),
                ],
              ),
            )),
        Expanded(
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: const [
                  Icon(
                    Icons.inbox,
                    size: iconSize,
                    color: Colors.black,
                  ),
                  Text(
                    "我的证件",
                    style: textStyle,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  /// 容量
  Widget _capacityBody() {
    return CustomCard(
      title: '容量',
      useUnderline: false,
      body: Container(
        width: double.maxFinite,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${useSize.roundToDouble()}G/${totalSize.roundToDouble()}G",
                  style: const TextStyle(
                      fontSize: 20, color: Colors.black, fontFamily: "黑体"),
                ),
                Text("${((useSize / totalSize) * 100).round().toString()}%"),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: LinearProgressIndicator(
                  value: useSize / totalSize,
                  backgroundColor: const Color.fromRGBO(245, 245, 253, 1),
                  color: Colors.blue,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      "管理空间",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 设置
  Widget _settingsBody(BuildContext context) {
    const titleStyle = TextStyle(color: Colors.black, fontSize: 15);
    const bodyStyle = TextStyle(color: Colors.grey, fontSize: 12);
    const double bodyHeight = 45;
    const double iconSize = 15;
    const Color iconsColor = Colors.grey;
    return CustomCard(
      title: "设置与服务",
      useUnderline: false,
      body: Column(
        children: [
          CustomRow(
            offstage: false,
            height: bodyHeight,
            onPressed: () {
              Navigator.pushNamed(context, "app-setup")
                  .then((value) => _getUserInfo());
            },
            children: const [
              Text("设置", style: titleStyle),
              CustomIconText(
                "账号、退出",
                style: bodyStyle,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
          ),
          CustomRow(
            offstage: false,
            height: bodyHeight,
            onPressed: () {},
            children: const [
              Text("个性设置", style: titleStyle),
              CustomIconText(
                "明星皮肤上线啦",
                style: bodyStyle,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
          ),
          CustomRow(
            offstage: false,
            height: bodyHeight,
            onPressed: () {},
            children: const [
              Text("更多服务", style: titleStyle),
              CustomIconText(
                "免流量卡、领无限空间",
                style: bodyStyle,
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: iconSize,
                  color: iconsColor,
                ),
              ),
            ],
          ),
          CustomRow(
            offstage: false,
            height: bodyHeight,
            onPressed: () {},
            children: const [
              Text("帮助与反馈", style: titleStyle),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 253, 1),
      body: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _headerBody(context),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            child: _cardBody(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: _capacityBody(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _settingsBody(context),
          ),
        ],
      ),
    );
  }
}
