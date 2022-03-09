class StructResponseResult {

  /// 状态码
  final StateCode code;

  /// 问题描述
  final String message;

  /// 返回结果
  final dynamic data;

  /// 构造函数
  const StructResponseResult(
      this.code,
      this.message,
      this.data
      );
}

/// 状态码
enum StateCode {
  SUCCESS,
  FAIL
}