import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/widget/common/card.dart';

class BrowseRecords extends StatefulWidget {

  const BrowseRecords({Key? key}) : super(key: key);

  @override
  _BrowseRecordsState createState() => _BrowseRecordsState();
}

class _BrowseRecordsState extends State<BrowseRecords> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        title: '最近',
        useUnderline: true,
        actions: SizedBox(
          height: 35,
          child: IconButton(
            iconSize: 25,
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(0),
            icon: Icon(isVisible? IconfontsData.show : IconfontsData.hidden, color: Colors.black),
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
          ),
        ),
        body: Visibility(
          visible: isVisible,
          replacement: Container(
            width: double.maxFinite,
            height: 120,
            alignment: Alignment.center,
            child: const Text('最近使用过的已隐藏', style: TextStyle(
                color: Colors.grey,
                fontSize: 15
            )),
          ),
          child: Container(
            width: double.maxFinite,
            height: 120,
            alignment: Alignment.center,
            child: const Text('最近没有过浏览记录', style: TextStyle(
                color: Colors.grey,
                fontSize: 15
            )),
          ),
        )
    );
  }

}