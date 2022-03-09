import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/views/search/home.dart';
import 'package:lj_netdisk/widget/common/search.dart';

class SortNavigation extends StatelessWidget {

  const SortNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    EdgeInsetsGeometry padding = const EdgeInsets.only(left: 15, right: 20);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.asset(CommonImagesData.homeNavigationAlbum, fit: BoxFit.contain),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text('相册', style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    )),
                  )
                ],
              ),
            ),
            onTap: () => showCustomSearch(
                context: context,
                query: '图片',
                delegate: HomeSearchDelegate('网盘专属福利')
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.asset(CommonImagesData.homeNavigationVideo, fit: BoxFit.contain),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text('视频', style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    )),
                  )
                ],
              ),
            ),
            onTap: () => showCustomSearch(
                context: context,
                query: '视频',
                delegate: HomeSearchDelegate('网盘专属福利')
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.asset(CommonImagesData.homeNavigationDocument, fit: BoxFit.contain),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text('文档', style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    )),
                  )
                ],
              ),
            ),
            onTap: () => showCustomSearch(
                context: context,
                query: '文档',
                delegate: HomeSearchDelegate('网盘专属福利')
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.asset(CommonImagesData.homeNavigationNovel, fit: BoxFit.contain),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text('小说', style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    )),
                  )
                ],
              ),
            ),
            onTap: () => showCustomSearch(
                context: context,
                query: '小说',
                delegate: HomeSearchDelegate('网盘专属福利')
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.asset(CommonImagesData.homeNavigationAudio, fit: BoxFit.contain),
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text('音频', style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                    )),
                  )
                ],
              ),
            ),
            onTap: () => showCustomSearch(
                context: context,
                query: '音频',
                delegate: HomeSearchDelegate('网盘专属福利')
            ),
          ),
        ),
      ],
    );
  }
}