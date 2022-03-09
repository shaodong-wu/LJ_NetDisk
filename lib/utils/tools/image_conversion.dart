import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageConvert {
  static Image base64OrUrlTurnImage(String base64OrUrlStr) {
    var httpreg = RegExp(
        r"(?=^.{3,255}$)(http(s)?:\/\/)?(www\.)?[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+(:\d+)*(\/\w+\.\w+)*([\?&]\w+=\w*)*");
    var base64reg = RegExp(
        r"^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{4}|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)$");
    if (base64OrUrlStr.isNotEmpty && httpreg.hasMatch(base64OrUrlStr)) {
      return Image.network(base64OrUrlStr);
    }

    if (base64OrUrlStr.isNotEmpty) {
      var temp = base64OrUrlStr.split(',');
      // 若base64无标头
      base64OrUrlStr = temp.length > 1 ? temp[1] : temp[0];
      if (!base64reg.hasMatch(base64OrUrlStr)) {
        return Image.asset("assets/images/use_page/user.png");
      }
      //解码
      Uint8List buffter = base64.decoder.convert(base64OrUrlStr);
      return Image.memory(buffter);
    }
    return Image.asset("assets/images/use_page/user.png");
  }
}
