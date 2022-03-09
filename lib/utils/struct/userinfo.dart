import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/utils/tools/image_conversion.dart';

class StructUserInfo {
  String id;
  String name;
  Image face;
  String phone;
  String? email;
  String? sex;
  DateTime? birth;
  String? autograph;

  StructUserInfo(
      {required this.id,
        required this.name,
        required this.face,
        required this.phone,
        this.email = "未绑定",
        this.sex = "保密",
        this.birth,
        this.autograph = "暂无个性签名"});

  StructUserInfo.fromJson(Map<String, dynamic> json)
      : id = json["id"].toString(),
        name = json["name"].toString(),
        phone = json["phone"].toString(),
        birth = DateTime.parse(json["birth"].toString()),
        sex = json["sex"].toString(),
        autograph = json["autograph"].toString(),
        email = json["email"].toString(),
        face = ImageConvert.base64OrUrlTurnImage(json["face"].toString());
}

