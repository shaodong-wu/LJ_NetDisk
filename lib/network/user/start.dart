import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/config/global_config.dart';
import 'package:pointycastle/asymmetric/api.dart';

import 'package:lj_netdisk/utils/struct/response_result.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';

import '../request.dart';

class NetWorkStartIndex {

  /// 用户登录
  static Future<StructResponseResult> login(String account, String password, String credential) async {
    final publicKey = RSAKeyParser().parse(GlobalConfig.PUBLIC_KEY) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(const JsonEncoder().convert({
      'id': account,
      'pwd': password,
      'credential': credential
    }));
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/start/login',
      method: 'POST',
      data: json.encode(encrypted.base64),
    );
    if (retJson['code'] == 0) {
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], null);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

  /// 用户退出
  static Future<bool> logOut() async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/start/logout',
      method: 'GET',
    );
    return true;
  }

}