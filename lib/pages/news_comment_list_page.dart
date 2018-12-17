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

  @override
  void initState() {
    super.initState();
    getNewsListData();
  }

  getNewsListData() async {
    Future.wait([
      Network.getNewsCommentList(widget.newsId),
      Network.getNewsCommentList(widget.newsId, true),
    ]).then((resList) {
      List dataList = [];
      Map longMap = resList.first;
      Map shortMap = resList.last;
      List longList = NewsCommentModel.modelsFromJsonList(longMap["comments"]);
      List shortList =
          NewsCommentModel.modelsFromJsonList(shortMap["comments"]);
      dataList.add("${longList.length}条长评论");
      dataList.addAll(longList);
      dataList.add("${shortList.length}条短评论");
      dataList.addAll(shortList);
      setState(() {
        _dataList = dataList;
        _title = "${longList.length + shortList.length}条评论";
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        elevation: 2.0,
      ),
      body: ListView.builder(
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
      ),
    );
  }
}
