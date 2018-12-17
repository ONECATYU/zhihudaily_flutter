// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return NewsModel(
      title: json['title'] as String,
      id: json['id'] as int,
      type: json['type'] as int,
      gaPrefix: json['ga_prefix'] as String,
      images: (json['images'] as List)?.map((e) => e as String)?.toList())
    ..image = json['image'] as String;
}

Map<String, dynamic> _$NewsModelToJson(NewsModel instance) => <String, dynamic>{
      'title': instance.title,
      'images': instance.images,
      'type': instance.type,
      'id': instance.id,
      'image': instance.image,
      'ga_prefix': instance.gaPrefix
    };
