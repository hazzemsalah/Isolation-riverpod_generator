import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.g.dart';


@JsonSerializable(createToJson: false)
class NotificationEntity {
  final String? image;
  final String? title;
  final String? body;
  final String? timestamp; 
  NotificationEntity({
    this.image,
    this.title,
    this.body,
    this.timestamp,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) => _$NotificationEntityFromJson(json);
}


@JsonSerializable(createToJson: false)
class NotificationResponse {
  @JsonKey(name: "data")
  final List<NotificationEntity>? data;

  NotificationResponse(this.data);

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);
}