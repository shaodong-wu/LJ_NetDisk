import 'dart:typed_data';

import 'package:lj_netdisk/config/network_config.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';

import '../request.dart';

class NetWorkFileIndex {

  /// 获取指定目录的所有文件
  static Future<StructResponseResult> getFiles(String directoryid) async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
        url: '/api/file/all',
        method: 'GET',
        params: {
          'directoryid': directoryid
        }
    );
    if (retJson['code'] == 0) {
      List<dynamic> list = retJson['results']['files'];
      List<StructFileDetail> results = [];
      for (int i = 0; i < list.length; i++) {
        results.add(StructFileDetail.fromJson(list[i], false));
      }
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], results);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

  /// 获取图片缩略图
  static String getImageUrl(String fileid, [int width = -1, int height = -1]) {
    return '${NetWorkConfig.baseUrl}/api/file/img/view?fileid=$fileid&width=$width&height=$height';
  }

  /// 将文件移入回收站
  static Future<StructResponseResult> softDeleteFiles(String directoryid, List<String> fileId) async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
        url: '/api/file/delete',
        method: 'POST',
        data: {
          'directoryid': directoryid,
          'files': [...fileId],
        }
    );
    if (retJson['code'] == 0) {
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], null);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

  /// 获取用户回收站的文件
  static Future<StructResponseResult> getRecycleFiles() async {
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: '/api/file/recycle',
      method: 'GET',
    );
    if (retJson['code'] == 0) {
      List<dynamic> list = retJson['results']['files'];
      List<StructFileDetail> results = [];
      for (int i = 0; i < list.length; i++) {
        results.add(StructFileDetail.fromJson(list[i], false));
      }
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], results);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

  /// 上传小文件
  static Future<StructResponseResult> uploadFile(String filePath, String directoryId, Function? progressCallback) async {
    Map<String, dynamic> retJson = await NetWorkRequest.uploadFile(
        url: '/api/file/upload',
        body: {
          'directoryid': directoryId
        },
        filePath: filePath,
        progressCallback: progressCallback
    );
    if (retJson['code'] == 0) {
      return StructResponseResult(StateCode.SUCCESS, retJson['msg'], null);
    }
    return StructResponseResult(StateCode.FAIL, retJson['msg'], null);
  }

}