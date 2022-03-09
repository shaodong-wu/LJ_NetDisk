import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lj_netdisk/common/bottom_bar_data.dart';
import 'package:lj_netdisk/config/router_config.dart';
import 'package:lj_netdisk/widget/custom_animated_bottom_bar.dart';
import 'package:uni_links/uni_links.dart';
import 'package:lj_netdisk/project_router.dart';

/// eum 类型
enum UniLinksType {
  string,
}

/// 项目页面的入口
class Entrance extends StatefulWidget {

  /// 页面索引位置
  final int? indexValue;

  /// 项目路由
  final ProjectRouter router = ProjectRouter();

  /// 构造函数
  Entrance({
    Key? key,
    this.indexValue,
  }) : super(key: key);

  @override
  _EntranceState createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> with SingleTickerProviderStateMixin {

  int _indexNum = 0;

  final UniLinksType _type = UniLinksType.string;
  StreamSubscription? _sub;
  ProjectRouter router = ProjectRouter();

  @override
  void initState() {
    super.initState();
    //  scheme初始化，保证有上下文，需要跳转页面
    initPlatformState();
    if (widget.indexValue != null) {
      _indexNum = widget.indexValue!;
    }
  }

  ///  初始化Scheme只使用了String类型的路由跳转
  ///  所以只有一个有需求可以使用[initPlatformStateForUriUniLinks]
  Future<void> initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    }
  }

  /// 使用[String]链接实现
  Future<void> initPlatformStateForStringUniLinks() async {
    String? initialLink;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      initialLink = await getInitialLink();
      if (initialLink != null) {
        redirect(initialLink);
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    // Attach a listener to the links stream
    _sub = linkStream.listen((String? link) {
      if (!mounted || link == null) return;
      //  跳转到指定页面
      redirect(link);
    }, onError: (Object err) {
      if (!mounted) return;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  /// 跳转页面
  void redirect(String link) {
    if (link.isEmpty) return;

    int indexNum = router.open(context, link);
    if (indexNum > -1 && _indexNum != indexNum) {
      setState(() {
        _indexNum = indexNum;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: _getTabPagesWidget(),
        ),
        bottomNavigationBar: CustomAnimatedBottomBar(
          selectedIndex: _indexNum,
          items: BottomBarData.list.map((item) {
            return MyBottomNavigationBarItem(
              selectedIcon: Image.asset(item['selectedIcon']),
              unselectedIcon: Image.asset(item['unselectedIcon']),
              title: Text(item['title']),
              textAlign: TextAlign.center,
            );
          }).toList(),
          onItemSelected: (int value) {
            if (_indexNum != value) {
              setState(() {
                _indexNum = value;
              });
            }
          }
        )
    );
  }

  /// 获取页面组件
  List<Widget> _getTabPagesWidget() {
    List<Widget> widgetList = [];
    for (var element in RouterConfig.routerMapping.values) {
      if (element.isTabPage) {
        widgetList.add(Offstage(
          offstage: _indexNum != element.entranceIndex,
          child: TickerMode(
            enabled: _indexNum == element.entranceIndex,
            child: element.widget
          )
        ));
      }
    }
    return widgetList;
  }
}