import 'package:flutter/foundation.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';

import '../request.dart';

class NetWorkSortIndex {

  /// 判断请求类型
  static Map<String, dynamic> _getReqUrl(String typeStr) {
    switch(typeStr) {
      case '图片':
      case '视频':
      case '小说':
      case '音频':
      case '文件夹':
        return {'reqUrl': '/api/file/img', 'isSort': true};
      case '文档':
        return {'reqUrl': '/api/file/text', 'isSort': true};
      default:
        return {'reqUrl': '/api/file/search', 'isSort': false};
    }
  }

  /// 获取搜索文件
  static Future<StructResponseResult> getSearchFiles(String keyword) async {
    Map<String, dynamic> reqType = _getReqUrl(keyword);
    Map<String, dynamic> retJson = await NetWorkRequest.request(
      url: reqType['reqUrl'],
      method: 'GET',
      params: (reqType['isSort'] as bool) ? null : {
        'filename': keyword
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

}