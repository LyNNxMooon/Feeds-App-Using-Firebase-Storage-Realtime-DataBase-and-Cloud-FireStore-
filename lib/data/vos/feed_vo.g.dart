// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedVO _$FeedVOFromJson(Map<String, dynamic> json) => FeedVO(
      id: json['id'] as int,
      feedTitle: json['feed_title'] as String,
      fileURL: json['file_url'] as String,
      fileType: json['file_type'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$FeedVOToJson(FeedVO instance) => <String, dynamic>{
      'id': instance.id,
      'feed_title': instance.feedTitle,
      'file_url': instance.fileURL,
      'file_type': instance.fileType,
      'created_at': instance.createdAt,
    };
