import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/network/file/search.dart';
import 'package:lj_netdisk/utils/struct/file_detail.dart';
import 'package:lj_netdisk/utils/struct/response_result.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';
import 'package:lj_netdisk/widget/common/loading.dart';
import 'package:lj_netdisk/widget/common/search.dart';
import 'package:lj_netdisk/widget/common/card.dart';
import 'package:lj_netdisk/widget/common/label.dart';
import 'package:lj_netdisk/widget/file/file_line_exhibition.dart';

class HomeSearchDelegate extends CustomSearchDelegate<dynamic> {

  /// 文件类型列表
  final List<Map<String, dynamic>> _fileType = [
    {'text': '文件夹',  'icon': IconfontsData.wenjianjia},
    {'text': '图片',    'icon': IconfontsData.tupian},
    {'text': '视频',    'icon': IconfontsData.shipin},
    {'text': '文档',    'icon': IconfontsData.wendang},
    {'text': '音频',    'icon': IconfontsData.yinpin},
    {'text': '其他',    'icon': IconfontsData.qita}
  ];


  HomeSearchDelegate(String hintText) : super(
    searchFieldLabel: hintText,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.search,
  );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: const TextTheme(
        headline6: TextStyle(
          decoration: TextDecoration.none,
        )
      ),
      backgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, shadowColor: Colors.transparent),
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(0),
        isCollapsed: true,
        filled: true,
        fillColor: Color.fromRGBO(245, 245, 253, 1.0),
        border: OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(50))
        ),
      )
    );
  }

  // 清空与搜索按钮
  @override
  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
        constraints: const BoxConstraints(maxHeight: 40),
        hintText: searchFieldLabel,
        prefixIcon: Icon(IconfontsData.sousuo, color: Colors.grey, size: 22),
        suffix: Container(
          alignment: AlignmentDirectional.center,
          width: 100.0,
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                visible: query.isNotEmpty,
                child: GestureDetector(
                  child: const Icon(
                    Icons.clear,
                    size: 20.0,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    query = "";
                    showSuggestions(context);
                  },
                ),
              ),
              const VerticalDivider(
                width: 25.0,
                thickness: 1.0,
                color: Colors.black12,
              ),
              GestureDetector(
                child: const Text(
                  "搜索",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  if (query.isEmpty) {
                    query = searchFieldLabel!;
                  }
                  showResults(context);
                },
              )
            ],
          ),
        ));
  }

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[];

  // 返回上级按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        iconSize: 28,
        alignment: const Alignment(7.0, 0.0),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        icon: const Icon(Icons.navigate_before, color: Colors.black),
        onPressed: query.isEmpty
            ? () => close(context, null) //点击时关闭整个搜索页面
            : () {
          query = "";
          showSuggestions(context);
        });
  }

  // 搜到到内容后的展现
  @override
  Widget buildResults(BuildContext context) {
    return searchList(context);
  }

  // 设置推荐
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsWidget = query.isEmpty ? recommend(context) : searchList(context);
    return suggestionsWidget;
  }

  // 搜索历史和文件类型
  Widget recommend(BuildContext context) {
    return _HistoryRecommend(
      fileType: _fileType,
      sortSearchAction: (sortType) {
          query = sortType;
          showResults(context);
      },
      historySearchAction: (keyword) {
        if (keyword != null) {
          query = keyword;
          showResults(context);
        }
      },
    );
  }

  // 搜索列表
  Widget searchList(BuildContext context) {
    return _SearchBody(keyword: query);
  }
}

class _SearchBody extends StatefulWidget {

  final List appBarLabelList = ["全部", "文件夹", "图片", "视频", "音频", "文档", "其他"];

  final String keyword;

  _SearchBody({
    Key? key,
    required this.keyword
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody> {

  /// 是否正在加载
  bool isLoading = true;

  /// 渲染列表
  List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    _saveQueryKey();
    _initChildren();
  }

  /// 保存搜索关键字
  void _saveQueryKey() async {
    List<dynamic> list = await LocalStorage.get('searchHistory') ?? [];
    Set<dynamic> set = list.toSet()..add(widget.keyword);
    await LocalStorage.save('searchHistory', set.toList());
  }

  /// 初始化搜索结果
  void _initChildren() async {
    StructResponseResult result = await NetWorkSortIndex.getSearchFiles(widget.keyword);
    List<Widget> children = [];
    if (result.code == StateCode.SUCCESS) {
      List list = result.data as List<StructFileDetail>;
      for (int i = 0; i < list.length; i++) {
        children.add(FileLineExhibition(list[i]));
      }
      setState(() {
        this.children = children;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          toolbarHeight: 40,
          automaticallyImplyLeading: false,
          title: CustomLabel(
            textList: widget.appBarLabelList,
            isSlide: true,
            onTap: (int value) {},
          ),
        ),
        body: isLoading
            ? const Center(child: CustomLoading())
            : ListView(children: children),
      )
    );
  }
}

class _HistoryRecommend extends StatefulWidget {

  final List<Map<String, dynamic>> fileType;

  final void Function(String?)? historySearchAction;

  final void Function(String)? sortSearchAction;

  const _HistoryRecommend({
    Key? key,
    required this.fileType,
    this.historySearchAction,
    this.sortSearchAction,
  }) : super(key: key);

  @override
  _HistoryRecommendState createState() => _HistoryRecommendState();
}

class _HistoryRecommendState extends State<_HistoryRecommend> {

  // 历史记录列表
  List<dynamic> searchHistoryList = [];

  @override
  void initState() {
    super.initState();
    _initSearchHistoryList();
  }

  void _initSearchHistoryList() async {
    List<dynamic> historyList = await LocalStorage.get('searchHistory');
    if (historyList != null && historyList.isNotEmpty) {
      setState(() => searchHistoryList = historyList);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isEmptyHistory = searchHistoryList.isNotEmpty;
    return SizedBox(
      height: 1500,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Visibility(
              visible: _isEmptyHistory,
              child: CustomCard(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0, bottom: 5.0),
                title: "搜索历史",
                titleStyle: const TextStyle(
                    fontSize: 17
                ),
                actions: GestureDetector(
                  child: Icon(IconfontsData.qingchu, size: 25),
                  onTap: () {
                    LocalStorage.remove('searchHistory');
                    setState(() {
                      searchHistoryList = [];
                    });
                  }, //点击图标清除搜索历史
                ),
                body: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: CustomLabel(
                    textList: searchHistoryList,
                    onTap: (historyIndex) {
                      if (widget.historySearchAction != null) {
                        widget.historySearchAction!(searchHistoryList[historyIndex]);
                      }
                    },
                  ),
                ),
              ),
            ),
            CustomCard(
                title: "文件类型",
                titleStyle: const TextStyle(
                    fontSize: 17
                ),
                padding: const EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 25.0),
                body: Container(
                  margin: const EdgeInsets.only(top: 4),
                  child: CustomLabel(
                    textList: widget.fileType,
                    minWith: 50,
                    labelPadding: const EdgeInsets.only(left: 8, top: 5, right: 15, bottom: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: (index) {
                      if (widget.sortSearchAction != null) {
                        widget.sortSearchAction!(widget.fileType[index]['text']);
                      }
                    },
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}
