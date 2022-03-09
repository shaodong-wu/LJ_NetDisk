import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/network/file/drive.dart';
import 'package:lj_netdisk/network/file/file.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';
import 'package:lj_netdisk/views/search/home.dart';
import 'package:lj_netdisk/widget/common/bottom_layer.dart';
import 'package:lj_netdisk/widget/common/loading.dart';
import 'package:lj_netdisk/widget/common/round_box.dart';
import 'package:lj_netdisk/widget/common/search_box.dart';
import 'package:lj_netdisk/widget/file/file_line_exhibition.dart';
import 'package:lj_netdisk/widget/file/image_show.dart';
import 'package:m_loading/m_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


class FilePageIndex extends StatefulWidget {

  const FilePageIndex({Key? key}) : super(key: key);

  @override
  _FilePageIndexState createState() => _FilePageIndexState();
}

class _FilePageIndexState extends State<FilePageIndex> {

  /// 是否正在加载
  // bool isLoading = true;

  final RefreshController _refreshController = RefreshController(initialRefresh: true);

  /// 目录堆栈
  List<StructFileDetail> directoryStack = [];

  /// 当前文件夹信息
  StructFileDetail currentFolder = const StructFileDetail('/', '/', true, null, null, null);

  /// 当前文件夹的文件列表
  List<StructFileDetail> currentlLst = [];

  @override
  void initState() {
    super.initState();
    _initRootDirectory();
  }

  /// 初始化用户目录文件
  Future<void> _initRootDirectory() async {
    // 获取文件夹和文件
    StructResponseResult folderResult = await NetWorkDriveIndex.getSubDirectories(currentFolder.fileId);
    StructResponseResult fileResult = await NetWorkFileIndex.getFiles(currentFolder.fileId);
    if (folderResult.code == StateCode.SUCCESS && fileResult.code == StateCode.SUCCESS) {
      setState(() {
        currentlLst = [];
        currentlLst.addAll(folderResult.data);
        currentlLst.addAll(fileResult.data);
        _refreshController.refreshCompleted();
      });
    }
  }

  /// 返回上一个文件夹
  void _backUpDirectory() {
    setState(() {
      currentFolder = directoryStack.removeLast();
      currentlLst = [];
      _initRootDirectory();
    });
  }

  /// 显示图片
  void _showImage(String fileNmae, String fileid) async {
    RegExp img = RegExp(r'.(jpg|gif|bmp|png|webp)$');
    if (img.hasMatch(fileNmae.toLowerCase())) {
      String result = NetWorkFileIndex.getImageUrl(fileid);
      showDialog(
        context: context,
        builder: (ctx) => ImageShow(imageUrl: result)
      );
    }
  }

  /// 删除文件
  void _deleteFiles(List<StructFileDetail> files) async {
    StructResponseResult result = await NetWorkFileIndex.softDeleteFiles(currentFolder.fileId, [files.first.fileId]);
    if (result.code == StateCode.SUCCESS) {
      setState(() => currentlLst.remove(files.first));
    }
    Fluttertoast.showToast(
        msg: result.code == StateCode.SUCCESS ? '删除成功' : '删除失败',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget? leading;
    if (directoryStack.isEmpty) {
      leading = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('分类', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
          )),
          Icon(IconfontsData.arrowdown, color: Colors.black, size: 20),
        ],
      );
    } else {
      leading = GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Icon(IconfontsData.arrowleft, color: Colors.black, size: 30)
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    currentFolder.fileName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: _backUpDirectory,
      );
    }

    /// 搜索框
    Widget search = Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: CustomSearchBox(
        title: '搜索网盘文件',
        backgroundColor: const Color.fromRGBO(249, 249, 251, 1),
        delegate: HomeSearchDelegate('搜索网盘文件')
      ),
    );

    /// 文件列表
    List<Widget> list = [];
    list.addAll(currentlLst.map((item) =>
      FileLineExhibition(
        item,
        onTap: (file, isFolder) async {
          if (isFolder) {
            setState(() {
              directoryStack.add(currentFolder);
              currentFolder = file;
              _initRootDirectory();
            });
          } else {
            _showImage(file.fileName, file.fileId);
          }
        },
        onLongPress: (file) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text("您确定要删除吗?"),
                actions: <Widget>[
                  FlatButton(
                    child: const Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop("Cancel");
                    },
                  ),
                  FlatButton(
                    child: const Text("确定"),
                    onPressed: () {
                      _deleteFiles([file]);
                      Navigator.of(context).pop("Ok");
                    },
                  )
                ],
              );
            },
          );
        },
      )
    ).toList());
    list.insert(0, search);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 100,
        leading: leading,
        actions: [
          CustomRoundBox(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 15),
            backgroundColor: const Color.fromRGBO(247, 247, 249, 1),
            child: Icon(IconfontsData.chuanshu, color: Colors.black, size: 18),
          ),
          CustomRoundBox(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 15),
            backgroundColor: const Color.fromRGBO(247, 247, 249, 1),
            child: Icon(IconfontsData.gengduo, color: Colors.black, size: 18),
          ),
        ]
      ),
      body: SmartRefresher(
        header: const ClassicHeader(
          completeText: '加载中...',
          idleText: '继续下拉刷新',
          releaseText: '松手即可刷新',
          refreshingText: '加载中...',
          spacing: 10,
          iconPos: IconPosition.top,
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12
          ),
          refreshingIcon: CustomLoading(size: 18),
          canTwoLevelIcon: CustomLoading(size: 18),
          failedIcon: CustomLoading(size: 18),
          twoLevelView: CustomLoading(size: 18),
          completeIcon: CustomLoading(size: 18),
          idleIcon: CustomLoading(size: 18),
          releaseIcon: CustomLoading(size: 18)
        ),
        onRefresh: _initRootDirectory,
        controller: _refreshController,
        child: ListView(
          padding: const EdgeInsets.only(top: 12),
          children: list,
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
                        onTap: () async {
                          // 关闭添加弹窗
                          Navigator.pop(context);
                          // 先权限申请
                          var result = await PhotoManager.requestPermissionExtend();
                          debugPrint(result.isAuth.toString());
                          if (result.isAuth) {
                            final List<AssetEntity>? assets = await AssetPicker.pickAssets(context, maxAssets: 1);
                            if (assets != null && assets.isNotEmpty) {
                              File? originFile = await assets.first.originFile;
                              if (originFile != null) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) => const Center(
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: BallCircleOpacityLoading(
                                        ballStyle: BallStyle(
                                          size: 5,
                                          color: Colors.white,
                                          ballType: BallType.solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                StructResponseResult res = await NetWorkFileIndex.uploadFile(originFile.path, currentFolder.fileId, null);
                                if (res.code == StateCode.SUCCESS) {
                                  // 关闭弹窗
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                    msg: "上传成功",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 12.0
                                  );
                                }
                              }
                            }
                          }
                        },
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