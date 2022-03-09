import 'package:flutter/cupertino.dart';

class AppSettingModel with ChangeNotifier {
  bool noteSwitch = true;
  bool nightMode = false;

  setData({
    bool noteSwitch = false,
    bool nightMode = false,
  }) {
    this.noteSwitch = noteSwitch;
    this.nightMode = nightMode;
    notifyListeners();
  }
}
