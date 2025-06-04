import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notification/data/repository/norification_repository_impl.dart';
import '../../notification/domain/interactor/notification_interactor.dart';
import '../../notification/domain/model/notification_model.dart';
import '../../notification/domain/repository/notification_repository.dart';
import '../network/api_service.dart';

part 'module.g.dart';

// Network provider
@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: false,
    responseBody: false,
    responseHeader: false,
    error: true,
    compact: false,
  ));
  return dio;
}

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService(ref.read(dioProvider));
}

// Repo provider
@riverpod
NotificationRepository notificationRepository(NotificationRepositoryRef ref) {
  return NotificationRepositoryImpl(ref.read(apiServiceProvider));
}

// Interactor provider
@riverpod
NotificationInteractor notificationInteractor(NotificationInteractorRef ref) {
  return NotificationInteractor(ref.read(notificationRepositoryProvider));
}

// notification provider
@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  NotificationState build() => const NotificationState.initial();

  Future<void> fetchNotifications() async {
    state = const NotificationState.loading();
    try {
      final notifications = await ref.read(notificationInteractorProvider).getNotifications();
      state = NotificationState.loaded(notifications);
    } catch (e) {
      state = NotificationState.error(e.toString());
    }
  }

  void reset() {
    state = const NotificationState.initial();
  }
}
