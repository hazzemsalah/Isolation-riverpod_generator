// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      image: json['image'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      timestamp: json['timestamp'] as String?,
    );

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
