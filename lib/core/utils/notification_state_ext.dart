import '../../notification/domain/model/notification_model.dart';

extension NotificationStateExtensions on NotificationState {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<NotificationModel> notifications) loaded,
    required T Function(String message) error,
  }) {
    if (this is NotificationInitial) {
      return initial();
    } else if (this is NotificationLoading) {
      return loading();
    } else if (this is NotificationLoaded) {
      return loaded((this as NotificationLoaded).notifications);
    } else if (this is NotificationError) {
      return error((this as NotificationError).message);
    }
    throw Exception('Unknown state: $this');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<NotificationModel> notifications)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) {
    if (this is NotificationInitial && initial != null) {
      return initial();
    } else if (this is NotificationLoading && loading != null) {
      return loading();
    } else if (this is NotificationLoaded && loaded != null) {
      return loaded((this as NotificationLoaded).notifications);
    } else if (this is NotificationError && error != null) {
      return error((this as NotificationError).message);
    }
    return orElse();
  }

  bool get isInitial => this is NotificationInitial;
  bool get isLoading => this is NotificationLoading;
  bool get isLoaded => this is NotificationLoaded;
  bool get isError => this is NotificationError;

  List<NotificationModel>? get notificationsOrNull {
    return this is NotificationLoaded ? (this as NotificationLoaded).notifications : null;
  }

  String? get errorMessageOrNull {
    return this is NotificationError ? (this as NotificationError).message : null;
  }
}