import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {

  /// 单例模式
  static SharedPreferences? _prefs;

  /// 构造函数私有化
  LocalStorage._();

  /// 内部提供初始化示例方法
  static _initInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// 持久化保存数据
  static Future<bool> save(String key, Object? value) async {
    await _initInstance();
    /// 进行json序列化保存
    return _prefs!.setString(key, const JsonEncoder().convert(value));
  }

  /// 获取本地存储的数据
  static Future<dynamic> get(String key) async {
    await _initInstance();
    /// 获取存储的数据
    String? content = _prefs!.getString(key);
    if (content != null) {
      return const JsonDecoder().convert(content);
    }
    return null;
  }

  /// 判断本地舒服存储指定的数据
  static Future<bool> hasKay(String key) async {
    await _initInstance();
    return _prefs!.containsKey(key);
  }

  /// 移除本地存储中指定的数据
  static Future<bool> remove(String key) async {
    await _initInstance();

    if (_prefs!.containsKey(key)) {
      return await _prefs!.remove(key);
    }
    return false;
  }

  /// 清除本地的所有数据 [谨用]
  static Future<bool> clear() async {
    await _initInstance();
    return _prefs!.clear();
  }
}
