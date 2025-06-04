// lib/notification/data/repository/notification_repository_impl.dart
import '../../../core/network/api_service.dart';
import '../../domain/model/notification_model.dart';
import '../../domain/repository/notification_repository.dart';
import '../mapper/norification_mapper.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiService _apiService;

  NotificationRepositoryImpl(this._apiService);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    final response = await _apiService.fetchNotifications();
    
    return NotificationMapper.toModelList(response.data ?? []);
  }
}