import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:zhihudaily_flutter/widgets/bottom_tool_bar.dart';
import 'package:zhihudaily_flutter/pages/news_comment_list_page.dart';
import 'package:zhihudaily_flutter/network/network.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({
    Key key,
    this.newsId,
  }) : super(key: key);

  final String newsId;

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailPage();
  }
}

class _NewsDetailPage extends State<NewsDetailPage> {
  int _commentNum = 0;
  int _popularityNum = 0;

  @override
  void initState() {
    super.initState();
    getNewsInfos();
  }

  getNewsInfos() async {
    Map info = await Network.getNewsExtra(widget.newsId);
    setState(() {
      _popularityNum = info["popularity"];
      _commentNum = info["comments"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: "http://daily.zhihu.com/story/${widget.newsId}",
        javaScriptMode: JavaScriptMode.unrestricted,
        onWebViewCreated: (webViewController) {},
      ),
      bottomNavigationBar: BottomToolBar(
        thumbNum: "$_popularityNum",
        commentNum: "$_commentNum",
        commentTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => NewsCommentListPage(newsId: widget.newsId),
              ),
            ),
      ),
    );
  }
}
