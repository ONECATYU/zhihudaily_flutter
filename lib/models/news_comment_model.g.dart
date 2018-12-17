// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsCommentModel _$NewsCommentModelFromJson(Map<String, dynamic> json) {
  return NewsCommentModel(
      author: json['author'] as String,
      content: json['content'] as String,
      avatar: json['avatar'] as String,
      time: json['time'] as int,
      id: json['id'] as int,
      likes: json['likes'] as int)
    ..replyTo = json['reply_to'] == null
        ? null
        : NewsCommentModel.fromJson(json['reply_to'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NewsCommentModelToJson(NewsCommentModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'content': instance.content,
      'avatar': instance.avatar,
      'time': instance.time,
      'id': instance.id,
      'likes': instance.likes,
      'reply_to': instance.replyTo
    };
