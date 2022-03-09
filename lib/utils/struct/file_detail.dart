class StructFileDetail {

  /// 文件ID
  final String fileId;

  /// 文件名字
  final String fileName;

  /// 是否为文件夹
  final bool isFolder;

  /// 文件大小
  final int? fileSize;

  /// 父文件ID
  final String? directoryId;

  /// 当前文件创建时间
  final String? createTime;

  /// 构造函数
  const StructFileDetail(
    this.fileId,
    this.fileName,
    this.isFolder,
    this.fileSize,
    this.directoryId,
    this.createTime
  );

  /// 将json数据转化为对象数据
  StructFileDetail.fromJson(Map<String, dynamic> json, this.isFolder)
      : fileId = (json['fileid'] as String?) ?? (json['id'] as String),
        fileName = (json['filename'] as String?) ?? (json['name'] as String),
        fileSize = json['size'] as int,
        directoryId = json['directoryid'] as String,
        createTime = json['createtime'] as String;

  /// 将对象转化为json数据
  static Map<String, dynamic> toJson(StructFileDetail fileDetail) => {
    "fileid": fileDetail.fileId,
    "filename": fileDetail.fileName,
    "size": fileDetail.fileSize,
    "directoryid": fileDetail.directoryId,
    "createtime": fileDetail.createTime,
  };

}