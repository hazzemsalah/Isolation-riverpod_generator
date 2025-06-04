
import '../../domain/model/notification_model.dart';
import '../entity/notification_entity.dart';

class NotificationMapper {
  static NotificationModel? toModel(NotificationEntity entity) {
    final image = entity.image;
    final title = entity.title;
    final body = entity.body;
    final timestamp = entity.timestamp;
    
    if (image == null || title == null || body == null || timestamp == null) {
      return null;
    }
    
    try {
      DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
    
    return NotificationModel(
      image: image,
      title: title,
      body: body,
      timestamp: timestamp,
    );
  }

  static List<NotificationModel> toModelList(List<NotificationEntity> entities) {
    return entities
        .map(toModel)
        .where((model) => model != null)
        .cast<NotificationModel>()
        .toList();
  }
}