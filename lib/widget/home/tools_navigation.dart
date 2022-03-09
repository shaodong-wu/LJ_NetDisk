import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/widget/common/card.dart';

class ToolsNavigation extends StatelessWidget {

  const ToolsNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomCard(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(CommonImagesData.phoneBackupIcon, width: 42, fit: BoxFit.contain),
                    const Text('手机备份', style:  TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ))
                  ],
                ),
                Column(
                  children: [
                    Image.asset(CommonImagesData.wechatBackupIcon, width: 42, fit: BoxFit.contain),
                    const Text('微信备份', style:  TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ))
                  ],
                ),
                Column(
                  children: [
                    Image.asset(CommonImagesData.fileRecoveryIcon, width: 42, fit: BoxFit.contain),
                    const Text('文件恢复', style:  TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ))
                  ],
                ),
                Column(
                  children: [
                    Image.asset(CommonImagesData.qrcodeCollect, width: 42, fit: BoxFit.contain),
                    const Text('当面收文件', style:  TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ))
                  ],
                ),
                Column(
                  children: [
                    Image.asset(CommonImagesData.pointsMallIcon, width: 42, fit: BoxFit.contain),
                    const Text('积分兑好礼', style:  TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ))
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(CommonImagesData.pdfToWordIcon, width: 42, fit: BoxFit.contain),
                  const Text('转为Word', style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ))
                ],
              ),
              Column(
                children: [
                  Image.asset(CommonImagesData.findImgIcon, width: 42, fit: BoxFit.contain),
                  const Text('分类找图', style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ))
                ],
              ),
              Column(
                children: [
                  Image.asset(CommonImagesData.textRecognitionIcon, width: 42, fit: BoxFit.contain),
                  const Text('文字识别', style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ))
                ],
              ),
              Column(
                children: [
                  Image.asset(CommonImagesData.fileCleanIcon, width: 42, fit: BoxFit.contain),
                  const Text('文件清理', style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ))
                ],
              ),
              Column(
                children: [
                  Image.asset(CommonImagesData.moreToolsIcon, width: 42, fit: BoxFit.contain),
                  const Text('全部工具', style:  TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}