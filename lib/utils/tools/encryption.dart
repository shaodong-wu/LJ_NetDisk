import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:lj_netdisk/config/global_config.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encryption {
  static Future<String> encodeString(String content) async {
    final publicKey =
    RSAKeyParser().parse(GlobalConfig.PUBLIC_KEY) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));

    List<int> sourceBytes = utf8.encode(content);
    int inputLen = sourceBytes.length;
    int maxLen = 117;
    List<int> totalBytes = [];
    for (var i = 0; i < inputLen; i += maxLen) {
      int endLen = inputLen - i;
      List<int> item;
      if (endLen > maxLen) {
        item = sourceBytes.sublist(i, i + maxLen);
      } else {
        item = sourceBytes.sublist(i, i + endLen);
      }
      totalBytes.addAll(encrypter.encryptBytes(item).bytes);
    }
    return base64.encode(totalBytes);
    // return await encrypter.encrypt(content).base64.toUpperCase();
  }
}
