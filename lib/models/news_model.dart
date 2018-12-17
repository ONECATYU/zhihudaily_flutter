import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsModel {
  String title;
  List<String> images;
  int type;
  int id;
  String image;

  @JsonKey(name: "ga_prefix")
  String gaPrefix;

  NewsModel({this.title, this.id, this.type, this.gaPrefix, this.images,});
  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);
  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  static List<NewsModel> modelsFromJsonList(List jsonList) {
    if (jsonList?.length == 0) return[];
    List<NewsModel> models = [];
    for (int i = 0; i < jsonList.length; i++) {
      Map json = jsonList[i];
      NewsModel model = NewsModel.fromJson(json);
      models.add(model);
    }
    return models;
  }
}