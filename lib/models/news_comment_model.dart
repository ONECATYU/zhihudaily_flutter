import 'package:json_annotation/json_annotation.dart';

part 'news_comment_model.g.dart';

@JsonSerializable()
class NewsCommentModel {
  String author;
  String content;
  String avatar;
  int time;
  int id;
  int likes;

  @JsonKey(name: "reply_to")
  NewsCommentModel replyTo;

  NewsCommentModel({
    this.author,
    this.content,
    this.avatar,
    this.time,
    this.id,
    this.likes,
  });

  factory NewsCommentModel.fromJson(Map<String, dynamic> json) => _$NewsCommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsCommentModelToJson(this);

  static List<NewsCommentModel> modelsFromJsonList(List jsonList) {
    if (jsonList?.length == 0) return[];
    List<NewsCommentModel> models = [];
    for (int i = 0; i < jsonList.length; i++) {
      Map json = jsonList[i];
      NewsCommentModel model = NewsCommentModel.fromJson(json);
      models.add(model);
    }
    return models;
  }

  String getTimeString() {
    if (time == null) return "";
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000,isUtc: true);
    String dateStr = "${date.month}-${date.day} ${date.hour}:${date.minute}";
    if (date.year != DateTime.now().year) {
      dateStr = "${date.year}-" + dateStr;
    }
    return dateStr;
  }
}
