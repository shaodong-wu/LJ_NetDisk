import 'package:lj_netdisk/utils/struct/file_detail.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';

import '../request.dart';

class NetWorkDriveIndex {

  /// 获取指定目录的所有文件夹
  static Future<StructResponseResult> getSubDirectories(String directoryid) async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/drive/sub',
      method: 'GET',
      params: {
        'directoryid': directoryid
      }
    );
    if (retJson['code'] == 0) {
      List<dynamic> list = retJson['results']['directorys'];
      List<StructFileDetail> results = [];
      for (int i = 0; i < list.length; i++) {
        results.add(StructFileDetail.fromJson(list[i], true));
      }
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], results);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

}