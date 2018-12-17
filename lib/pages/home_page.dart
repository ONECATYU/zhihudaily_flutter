import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:zhihudaily_flutter/pages/drawer_page.dart';
import 'package:zhihudaily_flutter/widgets/news_list_item.dart';
import 'package:zhihudaily_flutter/network/network.dart';
import 'package:zhihudaily_flutter/models/news_model.dart';
import 'package:zhihudaily_flutter/widgets/news_banner_item.dart';
import 'package:zhihudaily_flutter/pages/news_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final double _appBarHeight = 218;
  ScrollController _scrollController = new ScrollController();

  List _newsList = [];
  List<NewsModel> _topNewsModels = [];
  bool _isNotMoreData = false;
  bool _isLoad = false;
  DateTime _date;
  final DateTime _nowDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!_isLoad) {
          _isLoad = true;
          loadMoreNewsListData();
        }
      }
    });
    getNewsListData();
  }

  getNewsListData() async {
    Map res = await Network.getNewsList();
    List<NewsModel> models = NewsModel.modelsFromJsonList(res["stories"]);
    List<NewsModel> topModels =
        NewsModel.modelsFromJsonList(res["top_stories"]);
    String dateStr = res["date"];
    _date = DateTime.parse(dateStr);

    setState(() {
      _newsList = models;
      _topNewsModels = topModels;
    });
  }

  loadMoreNewsListData() async {
    if (_date == null) return;
    Map res =
        await Network.getNewsList("${_date.year}${_date.month}${_date.day}");
    List<NewsModel> models = NewsModel.modelsFromJsonList(res["stories"]);
    List allModels = [];
    allModels.addAll(_newsList);
    String dateStr = res["date"];
    _date = DateTime.parse(dateStr);
    _isLoad = false;
    allModels.add(_date);
    allModels.addAll(models);
    setState(() {
      _newsList = allModels;
    });
  }

  String _getDateDesc(DateTime date) {
    String dateDesc = "${_date.month}月${_date.day}日";
    String weekdayDesc = "";
    switch (date.weekday) {
      case 1:
        weekdayDesc = "星期一";
        break;
      case 2:
        weekdayDesc = "星期二";
        break;
      case 3:
        weekdayDesc = "星期三";
        break;
      case 4:
        weekdayDesc = "星期四";
        break;
      case 5:
        weekdayDesc = "星期五";
        break;
      case 6:
        weekdayDesc = "星期六";
        break;
      case 7:
        weekdayDesc = "星期日";
        break;
    }
    dateDesc += "  $weekdayDesc";
    if (date.year < _nowDate.year) {
      dateDesc = "${_date.year}年" + dateDesc;
    }
    return dateDesc;
  }

  Widget _buildTopBannerWidget() {
    return Container(
      color: Colors.white,
      child: Swiper(
        autoplay: true,
        itemCount: _topNewsModels.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6,
            activeSize: 6,
          ),
        ),
        itemBuilder: (ctx, index) {
          NewsModel model = _topNewsModels[index];
          return NewsBannerItem(
            imageUrl: model.image,
            title: model.title,
          );
        },
      ),
    );
  }

  Widget _buildNewsListWidget() {
    List<Widget> widgetList = [];
    widgetList.addAll(_newsList.map((data) {
      if (data is NewsModel) {
        NewsModel model = data;
        return InkWell(
          child: NewsListItem(
            title: model.title,
            imgUrl: model.images.first,
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) {
                return NewsDetailPage(
                  newsId: "${model.id}",
                );
              }),
            );
          },
        );
      }
      String dateDesc = "${_date.month}月${_date.day}日 ${_date.weekday}";
      return Container(
        color: Colors.blue,
        height: 44,
        child: Center(
          child: Text(
            _getDateDesc(data),
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList());

    ///添加一个footer提示
    widgetList.add(Container(
      height: 44.0,
      child: Center(
        child: Text(_isNotMoreData ? "已经全部加载完毕" : "正在加载更多..."),
      ),
    ));

    return SliverList(
      delegate: SliverChildListDelegate(widgetList),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerPage(),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: _appBarHeight,
            elevation: 2.0,
            title: Text("今日热闻"),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildTopBannerWidget(),
            ),
          ),
          _buildNewsListWidget(),
        ],
      ),
    );
  }
}
