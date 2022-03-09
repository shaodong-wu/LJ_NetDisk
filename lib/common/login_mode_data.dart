import 'images_data.dart';

class LoginModeData {

  static const List<Map<String, dynamic>> modeList = [
    {
      'platform': 'weixin',
      'logoImage': CommonImagesData.weixinLoginIcon,
      'onPressed': null
    },
    {
      'platform': 'weibo',
      'logoImage': CommonImagesData.weiboLoginIcon,
      'onPressed': null
    },
    {
      'platform': 'qq',
      'logoImage': CommonImagesData.qqLoginIcon,
      'onPressed': null
    }
  ];

}