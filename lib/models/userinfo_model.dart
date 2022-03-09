import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/network/request.dart';
import 'package:lj_netdisk/utils/struct/userinfo.dart';

class UserInfoModel with ChangeNotifier {

  /// 用户信息
  StructUserInfo _ui = StructUserInfo(
      id: "请登录",
      name: "请登录...",
      face: Image.asset(CommonImagesData.defaultUserImg),
      phone: "***********",
      birth: DateTime.now(),
      autograph: ""
  );

  /// 获取用户信息
  StructUserInfo get ui => _ui;

  /// 修改用户信息
  set ui(StructUserInfo userInfo) {
    _ui = userInfo;
    notifyListeners();
  }

  /// 构造函数
  UserInfoModel() {
    _getUserInfo();
  }

  /// 获取用户信息
  Future _getUserInfo() async {
    try {
      var res = await NetWorkRequest.request(url: "/api/user/info", method: 'GET');
      if (res["code"].toString() == "0") {
        ui = StructUserInfo.fromJson(res["results"]);
      }
    } catch (e) {
      //print(e);
    }
    notifyListeners();
  }

  /// 重置用户信息
  void reset() {
    ui = StructUserInfo(
        id: "请登录",
        name: "请登录...",
        face: Image.asset("assets/images/use_page/user.png"),
        phone: "***********",
        birth: DateTime.now(),
        autograph: ""
    );
    notifyListeners();
  }
}
