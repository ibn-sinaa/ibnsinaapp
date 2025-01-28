import '../../core/helpers/app_converter.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final int seen;
  final String createdAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.seen,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      seen: map['seen'] ?? 0,
      createdAt: AppConverter.isoToDateTimeText(map['created_at'] ?? ''),
    );
  }
}
