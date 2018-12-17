import 'package:dio/dio.dart';

class Network {
  static const String baseUrl = "https://news-at.zhihu.com";
  static final Dio dio = Dio();

  static Future<Map> getNewsList([String date]) async {
    Response res;
    if (date != null) {
      res = await dio.get("https://news-at.zhihu.com/api/4/news/before/$date");
    } else {
      res = await dio.get("https://news-at.zhihu.com/api/4/news/latest");
    }
    return res.data;
  }

  static Future<Map> getNewsExtra(String newsId) async {
    Response res =
        await dio.get("https://news-at.zhihu.com/api/4/story-extra/$newsId");
    return res.data;
  }

  static Future<Map> getNewsCommentList(String newsId,
      [bool isShort = false]) async {
    String path = isShort ? "short-comments" : "long-comments";
    Response res =
        await dio.get("https://news-at.zhihu.com/api/4/story/$newsId/$path");
    return res.data;
  }
}
