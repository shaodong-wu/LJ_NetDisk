import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/utils/struct/userinfo.dart';
import 'package:lj_netdisk/utils/tools/encryption.dart';

import '../request.dart';

class NetWorkUserIndex {
  /// 获取用户信息
  static Future<StructUserInfo> getUserInfo() async {
    try {
      /// 发起请求获取用户信息
      var res =
      await NetWorkRequest.request(url: "/api/user/info", method: 'GET');

      /// 获取成功
      if (res["code"].toString() == "0") {
        return StructUserInfo.fromJson(res["results"]);
      }
    } catch (e) {
      print(e);
    }
    return StructUserInfo(
        id: "请登录",
        name: "请登录...",
        face: Image.asset("lib/assets/images/user_page/user.png"),
        phone: "***********",
        birth: DateTime.now(),
        autograph: "");
  }

  static Future<bool> updateUserInfo(StructUserInfo userInfo) async {
    try {
      var data = await Encryption.encodeString(const JsonEncoder().convert({
        "name": userInfo.name,
        "phone": userInfo.phone,
        "sex": userInfo.sex,
        "autograph": userInfo.autograph,
        "birth": userInfo.birth.toString(),
        "email": userInfo.email,
      }));
      Map<String, dynamic> retJson = await NetWorkRequest.request(
        url: "/api/user/change/info",
        method: "POST",
        data: json.encode(data),
      );
      if (retJson["code"].toString() == "0") {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
