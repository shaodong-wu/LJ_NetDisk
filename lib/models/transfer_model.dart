import 'package:flutter/cupertino.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';

class TransferModel with ChangeNotifier {

  /// 传输队列
  Set<StructFileDetail> _transfQueue = {};
  Set<StructFileDetail> get transfList => _transfQueue;
  set transfList(Set<StructFileDetail> item) {
    _transfQueue.addAll(item);
    notifyListeners();
  }

  TransferModel() {
   // this._transfQueue
  }

  void enQueue(StructFileDetail file) {
    _transfQueue.add(file);
    notifyListeners();
  }

}