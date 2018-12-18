import 'package:flutter/material.dart';

import 'package:zhihudaily_flutter/widgets/news_comment_list_item.dart';
import 'package:zhihudaily_flutter/network/network.dart';
import 'package:zhihudaily_flutter/models/news_comment_model.dart';

class NewsCommentListPage extends StatefulWidget {
  NewsCommentListPage({
    Key key,
    this.newsId,
  }) : super(key: key);

  final String newsId;

  @override
  State<StatefulWidget> createState() {
    return _NewsCommentListPageState();
  }
}

class _NewsCommentListPageState extends State<NewsCommentListPage> {
  String _title = "";
  List _dataList = [];
  bool _isLoadData = false;

  @override
  void initState() {
    super.initState();
    getNewsListData();
  }

  getNewsListData() async {
    _isLoadData = true;
    Future.wait([
      Network.getNewsCommentList(widget.newsId),
      Network.getNewsCommentList(widget.newsId, true),
    ]).then((resList) {
      _isLoadData = false;
      List dataList = [];
      Map longMap = resList.first;
      Map shortMap = resList.last;
      List longList = NewsCommentModel.modelsFromJsonList(longMap["comments"]);
      List shortList =
          NewsCommentModel.modelsFromJsonList(shortMap["comments"]);
      if (longList.length > 0) {
        dataList.add("${longList.length}条长评论");
        dataList.addAll(longList);
      }
      if (shortList.length > 0) {
        dataList.add("${shortList.length}条短评论");
        dataList.addAll(shortList);
      }
      if (dataList.length > 0) {
        setState(() {
          _dataList = dataList;
          _title = "${longList.length + shortList.length}条评论";
        });
      }
    });
  }

  Widget _buildHeader(String title) {
    return Container(
      color: Colors.white,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_dataList.length == 0 && _isLoadData) {
      body = Center(
        child: Text(
          "正在加载...",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
      );
    } else if (_dataList.length == 0) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/message.png"),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "暂无评论",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
      );
    } else {
      body = ListView.builder(
        itemBuilder: (ctx, index) {
          var model = _dataList[index];
          if (model is String) {
            return _buildHeader(model);
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0),
            child: NewsCommentListItem(
              comment: model as NewsCommentModel,
            ),
          );
        },
        itemCount: _dataList.length,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        elevation: 2.0,
      ),
      body: body,
    );
  }
}
