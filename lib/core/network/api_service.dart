import 'dart:isolate';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../../notification/data/entity/notification_entity.dart';

class ApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://raw.githubusercontent.com/shabeersha/test-api/main';

  ApiService(this._dio);

  Future<NotificationResponse> fetchNotifications() async {
    try {
      final response = await _dio.get('$_baseUrl/test-notifications.json');
      
      if (response.statusCode == 200) {
        return await Isolate.run(() => _processResponseData(response.data));
      }
      throw Exception('Failed to load notifications: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  static NotificationResponse _processResponseData(dynamic responseData) {
    final jsonData = responseData is String
        ? json.decode(responseData)
        : responseData;
        
    return NotificationResponse.fromJson(jsonData as Map<String, dynamic>);
  }
}