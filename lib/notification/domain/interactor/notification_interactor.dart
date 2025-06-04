import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

class NotificationInteractor {
  final NotificationRepository _repository;

  NotificationInteractor(this._repository);

  Future<List<NotificationModel>> getNotifications() async {
    return await _repository.getNotifications();
  }
}
