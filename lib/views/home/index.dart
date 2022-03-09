import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/styles/index.dart';
import 'package:lj_netdisk/views/search/home.dart';
import 'package:lj_netdisk/widget/common/bottom_layer.dart';
import 'package:lj_netdisk/widget/common/round_box.dart';
import 'package:lj_netdisk/widget/common/search_box.dart';
import 'package:lj_netdisk/widget/home/advertising_rotation.dart';
import 'package:lj_netdisk/widget/home/browse_records.dart';
import 'package:lj_netdisk/widget/home/document_scan.dart';
import 'package:lj_netdisk/widget/home/sort_navigation.dart';
import 'package:lj_netdisk/widget/home/synchronous_space.dart';
import 'package:lj_netdisk/widget/home/tools_navigation.dart';

class HomePageIndex extends StatefulWidget {

  const HomePageIndex({Key? key}) : super(key: key);

  @override
  _HomePageIndexState createState() => _HomePageIndexState();
}

class _HomePageIndexState extends State<HomePageIndex> {

  @override
  Widget build(BuildContext context) {

    /// 首页系统主题
    SystemChrome.setSystemUIOverlayStyle(SystemStatusBarStyles.dark);

    /// 模块之间的间距
    EdgeInsetsGeometry padding = const EdgeInsets.only(bottom: 10);

    /// 首页搜索框
    final Widget buildTitle = SizedBox(
      width: 230,
      height: 40,
      child: CustomSearchBox(
          title: '网盘专属福利',
          delegate: HomeSearchDelegate('网盘专属福利')
      ),
    );

    /// 首页 头部按钮
    final List<Widget>? buildActions = [
      CustomRoundBox(
        margin: const EdgeInsets.only(right: 15),
        child: Icon(IconfontsData.chuanshu, color: Colors.black, size: 20),
      ),
      CustomRoundBox(
        margin: const EdgeInsets.only(right: 15),
        child: Icon(IconfontsData.saoyisao, color: Colors.black, size: 20),
      )
    ];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 253, 1),
      appBar: AppBar(
          title: buildTitle,
          actions: buildActions,
          backgroundColor: const Color.fromRGBO(245, 245, 253, 1),
          shadowColor: Colors.transparent
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: RefreshIndicator(
          onRefresh: () async { },
          child: ListView(
            children: [

              /// 头部大导航
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 30),
                child: SortNavigation(),
              ),

              /// 工具模块
              Padding(
                padding: padding,
                child: const ToolsNavigation(),
              ),

              /// 横幅视图
              Padding(
                padding: padding,
                child: const AdvertisingRotation()
              ),

              /// 最近浏览记录
              Padding(
                padding: padding,
                child: const BrowseRecords()
              ),

              /// 文档扫描
              Padding(
                padding: padding,
                child: const DocumentScan(),
              ),

              /// 同步空间
              Padding(
                padding: padding,
                child: const SynchronousSpace(),
              ),

              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text('浪尖网盘  ·  让美好生活永远陪伴', style: DefaultTextStyles.tipGreetingStyle),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Image.asset(CommonImagesData.addNewUpload, fit: BoxFit.fill),
        onPressed: () {
          EdgeInsetsGeometry padding = const EdgeInsets.only(top: 10, left: 10, right: 20);
          CustomBottomLayer.show(
            height: 320,
            context: context,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnScan, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('扫一扫', style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnPhoto, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('上传照片', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnVideo, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('上传视频', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnFile, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('上传文档', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnMusic, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('上传音乐', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnOther, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('上传其他文件', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 8),
                alignment: Alignment.center,
                child: const Text('新建', style: TextStyle(
                  color: Colors.grey
                ),)
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnFolder, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('新建文件夹', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addCreateShare, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('新建共享', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnNote, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('新建笔记', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addHomeworkCollect, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('收作业', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnWord, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('新建Word', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: padding,
                        child: Column(
                          children: [
                            Image.asset(CommonImagesData.addBtnPPT, width: 50, height: 50, fit: BoxFit.contain),
                            const Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text('新建PPT', style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                              )),
                            )
                          ],
                        ),
                      ),
                      onTap: null,
                    ),
                  ],
                ),
              )
            ]
          );
        },
      ),
    );
  }
}