import 'package:lj_netdisk/utils/struct/response_result.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';

import '../request.dart';

class NetWorkVCodeIndex {

  /// 获取验证码, 返回 Base64 编码图片
  static Future<StructResponseResult> getImageVCode([width, height]) async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/public/img/getvcode',
      method: 'GET',
    );

    if (retJson['code'] == 0) {
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], retJson['results']['Image']);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

  /// 检查验证码, 返回校验成功的凭证
  static Future<StructResponseResult> checkImageVCode(String code) async {
    String vcodeVoucher = await LocalStorage.get('vcodeVoucher') as String;
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/public/img/checkvcode',
      method: 'GET',
      header: {
        'Cookie-Credentials': vcodeVoucher.split(';')[0]
      },
      params: {
        'code': code
      },
    );

    if (retJson['code'] == 0) {
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], retJson['results']['credential']);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

}