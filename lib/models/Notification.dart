class NotificationItem {
  final int? id;
  final int userId;
  final String title;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      dateTime: DateTime.parse(json['date_time']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'message': message,
        'date_time': dateTime.toIso8601String(),
      };
}
