import 'package:feeds/utils/enums.dart';
import 'package:json_annotation/json_annotation.dart';
part 'feed_vo.g.dart';

@JsonSerializable()
class FeedVO {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'feed_title')
  String feedTitle;
  @JsonKey(name: 'file_url')
  String fileURL;
  @JsonKey(name: 'file_type')
  String fileType;
  @JsonKey(name: 'created_at')
  String createdAt;

  FeedVO(
      {required this.id,
      required this.feedTitle,
      required this.fileURL,
      required this.fileType,
      required this.createdAt});

  FileType get getFileType {
    if (fileType.toLowerCase() == FileType.image.name) {
      return FileType.image;
    }
    if (fileType.toLowerCase() == FileType.video.name) {
      return FileType.video;
    }

    return FileType.file;
  }

  factory FeedVO.fromJson(Map<String, dynamic> json) => _$FeedVOFromJson(json);

  Map<String, dynamic> toJson() => _$FeedVOToJson(this);
}
