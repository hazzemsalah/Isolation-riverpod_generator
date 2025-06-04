import 'package:new_project/core/utils/notification_state_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di_module/module.dart';
import '../../../core/utils/date_formatter.dart';
import '../../domain/model/notification_model.dart';

part 'notification_viewmodel.g.dart';

@riverpod
class NotificationViewModel extends _$NotificationViewModel {
  @override
  void build() {}

  Future<void> fetchNotifications() async {
    await ref.read(notificationNotifierProvider.notifier).fetchNotifications();
  }

  void resetNotifications() {
    ref.read(notificationNotifierProvider.notifier).reset();
  }

  String formatDateTime(String timestampString) {
    return DateFormatter.formatDateTime(timestampString);
  }

  String formatDateTimeDetailed(String timestampString) {
    return DateFormatter.formatDateTimeDetailed(timestampString);
  }

  @override
  NotificationState get state => ref.read(notificationNotifierProvider);

  bool get isLoading => state.maybeWhen(loading: () => true, orElse: () => false);

  bool get hasError => state.maybeWhen(error: (_) => true, orElse: () => false);

  List<NotificationModel> get notifications =>
      state.maybeWhen(loaded: (notifications) => notifications, orElse: () => []);
}
