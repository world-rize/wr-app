
import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class Announcement {
  Announcement({
    @required this.title,
    @required this.content,
    @required this.createdAt,
  });

  String title;

  String content;

  DateTime createdAt;

  factory Announcement.fromJson(Map<dynamic, dynamic> json) {
    return _$AnnouncementFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);
}
