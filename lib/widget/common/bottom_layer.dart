import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';

class CustomBottomLayer {

  static Future<T?> show<T> ({
    required BuildContext context,
    String? title,
    double? height,
    EdgeInsetsGeometry? padding,
    List<Widget>? children = const <Widget>[],
    VoidCallback? onOk,
    VoidCallback? onCancel,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        List<Widget> _list = [
          Offstage(
            offstage: onCancel == null || onOk == null || title == null,
            child: ListTile(
              leading: onCancel == null ? null : IconButton(
                alignment: Alignment.bottomLeft,
                icon: Icon(IconfontsData.arrowleft, size: 30),
                onPressed: onCancel,
              ),
              title: title == null ? null : Text(title, style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "黑体",
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: onOk == null ? null : TextButton(
                child: const Text("完成", style: TextStyle(fontSize: 18)),
                onPressed: onOk,
              )
            ),
          ),
        ];
        _list.addAll(children!.toList());
        return SizedBox(
          height: height,
          child: ListView(
            padding: padding ?? const EdgeInsets.only(top: 20, bottom: 20),
            children: _list,
          ),
        );
      },
    );
  }
}
