import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';

class FileLineExhibition extends StatefulWidget {

  /// 文件详情
  final StructFileDetail file;

  /// 点击事件
  final void Function(StructFileDetail file, bool isFolder)? onTap;

  /// 长按事件
  final void Function(StructFileDetail file)? onLongPress;

  const FileLineExhibition(this.file, {
    Key? key,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  _FileLineExhibitionState createState() => _FileLineExhibitionState();
}

class _FileLineExhibitionState extends State<FileLineExhibition> {

  /// 是否选中当前文件或文件夹
  bool isSelected = false;

  /// 获取文件夹大小
  String getFileSize(int fileSize) {
    String  size;
    //内存转换
    if(fileSize < 0.1 * 1024){                            //小于0.1KB，则转化成B
      size = fileSize.toString();
      size = size.substring(0, size.indexOf(".")+3) + 'B';
    }else if(fileSize < 0.1 * 1024 * 1024){            //小于0.1MB，则转化成KB
      size = (fileSize/1024).toString();
      size = size.substring(0,size.indexOf(".")+3) + 'KB';
    }else if(fileSize < 0.1 * 1024 * 1024 * 1024){        //小于0.1GB，则转化成MB
      size = (fileSize/(1024 * 1024)).toString() ;
      size = size.substring(0,size.indexOf(".")+3) + 'MB';
    }else{                                            //其他转化成GB
      size = (fileSize/(1024 * 1024 * 1024)).toString();
      size = size.substring(0,size.indexOf(".")+3) + 'GB';
    }
    return size;
  }

  /// 获取文件类型Icon
  String getFileType(bool isFolder, {String? suffix}) {
    if (isFolder) {
      return CommonImagesData.fileType['folder'] as String;
    }
    return CommonImagesData.fileType[suffix] ?? CommonImagesData.fileType['other'] as String;
  }

  @override
  Widget build(BuildContext context) {

    Widget selected = Checkbox(
      value: isSelected,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          setState(() {
            isSelected = newValue;
          });
        }
      },
    );

    Widget unSelected = Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 1.5,
            color: const Color.fromRGBO(225, 225, 225, 1)
        )
      ),
    );

    return GestureDetector(
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
        leading: Image.asset(
          widget.file.isFolder? getFileType(true) : getFileType(false, suffix: widget.file.fileName.split('.')[1]),
          width: 40,
          fit: BoxFit.contain
        ),
        title: Text(widget.file.fileName, style: const TextStyle(
          fontSize: 14,
          color: Colors.black
        )),
        subtitle: Row(
          children: [
            if(widget.file.createTime != null) Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Text(widget.file.createTime as String, style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey
              )),
            ),
            if(widget.file.fileSize != null) Text(getFileSize(widget.file.fileSize as int), style: const TextStyle(
                fontSize: 12,
                color: Colors.grey
            )),
          ]
        ),
        trailing: isSelected? selected : unSelected,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!(widget.file, widget.file.isFolder);
          }
        },
      ),
      onLongPress: widget.file.isFolder? null : () {
        if (widget.onLongPress != null) {
          widget.onLongPress!(widget.file);
        }
      },
    );
  }
}

// enum FileType {
//   apk,
//   archive,
//   bt,
//   cad,
//   epub,
//   exe,          // 应用程序
//   folder,       // 文件夹
//   hidespace,
//   html,         // 网页
//   image,
//   keynote,
//   music,
//   number,
//   numbers,
//   other,
//   pages,
//   pand,
//   pdf,
//   ppt,
//   psd,
//   sharefolder,
//   enterprise,
//   txt,
//   vcf,
//   video,
//   vsd,
//   word
// }

// extension FileTypeExtension on FileType {
//   String get name => describeEnum(this);
//   String get displayTitle {
//     return CommonImagesData.fileType[name] ?? '';
//   }
// }