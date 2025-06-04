import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';

@freezed
abstract class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String image,
    required String title,
    required String body,
    required String timestamp,
  }) = _NotificationModel;
}

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = NotificationInitial;
  const factory NotificationState.loading() = NotificationLoading;
  const factory NotificationState.loaded(List<NotificationModel> notifications) = NotificationLoaded;
  const factory NotificationState.error(String message) = NotificationError;
}